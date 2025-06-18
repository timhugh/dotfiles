local function format_changed_hunks()
  local hunks = require('gitsigns').get_hunks()

  if not hunks then
    vim.notify("No changed hunks found", vim.log.levels.WARN)
    return
  end

  for _, hunk in ipairs(hunks) do
    if hunk.added.count > 0 then
      local start_line = hunk.added.start - 1
      local end_line = start_line + hunk.added.count
      vim.lsp.buf.format({
        range = {
          start = { start_line, 0 },
          ["end"] = { end_line, 0 },
        },
      })
    end
  end
end

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentRangeFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = format_changed_hunks,
    })
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
  vim.keymap.set("n", "gen", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, { desc = "Go to next diagnostic" })
  vim.keymap.set("n", "gep", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, { desc = "Go to previous diagnostic" })

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

local augroup = vim.api.nvim_create_augroup('my.lsp', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    on_attach(client, bufnr)
  end,
})

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
