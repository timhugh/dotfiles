local M = {}

local utils = require('lsp.utils')

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
