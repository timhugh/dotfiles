local M = {}

local function format_changed_hunks()
  local hunks = require('gitsigns').get_hunks()
  if not hunks then return end

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

M.configure_lsp = function(server_name, config)
  config = config or {}

  local default_config = {
    on_attach = function(client, bufnr)
      if config.on_attach then
        config.on_attach(client, bufnr)
      end
      M.on_attach(client, bufnr)
    end,
  }

  local merged_config = vim.tbl_deep_extend('force', default_config, config)
  vim.lsp.config(server_name, merged_config)
  vim.lsp.enable(server_name, true)
end

M.setup = function()
  require('lsp.commands')
  require('core.autoloader').load("lsp/configs")
end
return M
