M = {}

-- some LSPs (like copilot) are not actually LSPs and need to be handled differently at times
local unsupported_lsps = {
  copilot = true,
}

local function is_unsupported_lsp(client)
  return unsupported_lsps[client.name] or false
end

local function is_supported_lsp(client)
  return not is_unsupported_lsp(client)
end

-- This is adapted from https://artem.rocks/posts/workspace_diagnostics_nvim
-- I added some extra checks to ensure that the client is actually going to provide diagnostics correctly (e.g. not copilot)
--
-- It works by using git ls-files at launch to get all files in the workspace, then triggering diagnostics for each file.
-- There is probably going to be some testing needed with different LSPs, and I have a little bit of concern around caching
-- all of the files at launch and whether or not that will be a performance problem, and also whether or not it will update
-- correctly as files are changed.
local function lsp_supports_workspace_diagnostics(client)
  return vim.tbl_get(client.server_capabilities, 'textDocumentSync', 'openClose') and is_supported_lsp(client)
end

M.loaded_clients = {}
local function trigger_workspace_diagnostics(client, bufnr, workspace_files)
  if vim.tbl_contains(M.loaded_clients, client.id) then
    return
  end
  table.insert(M.loaded_clients, client.id)

  if not lsp_supports_workspace_diagnostics(client) then
    return
  end

  for _, path in ipairs(workspace_files) do
    if path == vim.api.nvim_buf_get_name(bufnr) then
      goto continue
    end

    local filetype = vim.filetype.match({ filename = path })

    if not vim.tbl_contains(client.config.filetypes, filetype) then
      goto continue
    end

    local params = {
      textDocument = {
        uri = vim.uri_from_fname(path),
        version = 0,
        text = vim.fn.join(vim.fn.readfile(path), "\n"),
        languageId = filetype
      }
    }
    client:notify('textDocument/didOpen', params)

    ::continue::
  end
end

local function get_workspace_files()
  local all_files = vim.fn.split(vim.fn.system('git ls-files'), "\n")
  local absolute_files = vim.tbl_map(function(path) return vim.fn.fnamemodify(path, ":p") end, all_files)
  -- git ls-files can return files that don't actually exist (e.g. if they were deleted but not committed)
  local existing_files = vim.tbl_filter(function(path) return vim.fn.filereadable(path) == 1 end, absolute_files)
  return existing_files
end
M.workspace_files = get_workspace_files()

local function format_changed_hunks()
  local hunks = require('gitsigns').get_hunks()

  if not hunks then
    return
  end

  for _, hunk in ipairs(hunks) do
    if hunk.added.count > 0 then
      local start_line = hunk.added.start - 1
      local end_line = start_line + hunk.added.count
      vim.lsp.buf.format({
        range = {
          start = { start_line, 0 },
          ["end"] = { end_line, 0 }, -- end is a reserved keyword in Lua
        },
        async = false,
      })
    end
  end
end

M.on_attach = function(client, bufnr)
  vim.notify('attaching buffer ' .. bufnr .. ' to LSP client ' .. client.name, vim.log.levels.INFO)
  if client.server_capabilities.documentRangeFormattingProvider then
    vim.notify("LSP " .. client.name .. " supports document range formatting", vim.log.levels.INFO)
    if vim.b[bufnr].lsp_format_hunks_autocmd then
      vim.notify(
        string.format(
          "LSP %s attempted to duplicate format_hunks autocmd for buffer %d. Formatting capability might need to be disabled.",
          client.name, bufnr
        ),
        vim.log.levels.WARN
      )
      return
    end
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = format_changed_hunks,
    })
    vim.b[bufnr].lsp_format_hunks_autocmd = true
  end

  trigger_workspace_diagnostics(client, bufnr, M.workspace_files)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })

  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })

  vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, { desc = "Show hover" })
  vim.keymap.set("n", "<leader>lh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "Toggle inlay hints" })

  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format document" })

  vim.keymap.set("n", "<leader>lq", function()
    vim.lsp.buf.code_action({
      context = { only = { "quickfix" } },
      apply = true,
    })
  end, { desc = "Quickfix code action" })
end

-- local augroup = vim.api.nvim_create_augroup('my.lsp', {})
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = augroup,
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     local bufnr = args.buf
--     on_attach(client, bufnr)
--   end,
-- })

vim.api.nvim_create_user_command('LspLog', function()
  local log_path = vim.lsp.get_log_path()
  if log_path then
    vim.cmd('edit ' .. log_path)
  else
    vim.notify("LSP log path not found", vim.log.levels.ERROR)
  end
end, { desc = "Open LSP log" })

vim.api.nvim_create_user_command('LspInfo', function()
  vim.cmd('checkhealth vim.lsp')
end, { desc = "Show LSP health dashboard" })

vim.api.nvim_create_user_command('LspRestart', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if is_supported_lsp(client) then
      vim.lsp.enable(client.name, false)
      vim.lsp.enable(client.name, true)
    end
  end
end, { desc = "Restart LSP servers" })

vim.lsp.enable('gdscript')

vim.lsp.enable('sourcekit')

vim.lsp.enable('clangd')
vim.lsp.enable('cmake')

vim.lsp.enable('ruby_lsp')
-- temp disabled until I set up project-specific configs
-- vim.lsp.enable('solargraph')
-- vim.lsp.enable('sorbet')
-- vim.lsp.enable('standardrb')
vim.lsp.enable('rubocop')

return M
