local M = {}

local utils = require('lsp.utils')

-- This is adapted from https://artem.rocks/posts/workspace_diagnostics_nvim
-- I added some extra checks to ensure that the client is actually going to provide diagnostics correctly (e.g. not copilot)
--
-- It works by using git ls-files at launch to get all files in the workspace, then triggering diagnostics for each file.
-- There is probably going to be some testing needed with different LSPs, and I have a little bit of concern around caching
-- all of the files at launch and whether or not that will be a performance problem, and also whether or not it will update
-- correctly as files are changed.
local function lsp_supports_workspace_diagnostics(client)
  return vim.tbl_get(client.server_capabilities, 'textDocumentSync', 'openClose') and utils.is_supported_lsp(client)
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
  if client.server_capabilities.documentRangeFormattingProvider then
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
      context = {
        diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
        only = { "quickfix" }
      },
      apply = true,
    })
  end, { desc = "Quickfix code action" })
end

M.setup = function(server_name, config)
  config = config or {}
  local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_ok then
    return
  end

  local custom_on_attach = config.on_attach
  config.on_attach = function(client, bufnr)
    if custom_on_attach then
      custom_on_attach(client, bufnr)
    end
    M.on_attach(client, bufnr)
  end

  local default_config = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }

  local merged_config = vim.tbl_deep_extend('force', default_config, config)

  if lspconfig[server_name] then
    lspconfig[server_name].setup(merged_config)
  else
    vim.notify(string.format("LSP config for %s not found", server_name), vim.log.levels.WARN)
  end
end

require('lsp.commands')
require('core.autoloader').load("lsp.configs")

return M
