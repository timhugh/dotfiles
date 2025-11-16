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
end

--- @param server_name string
--- @param config vim.lsp.Config
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
  require('util.autoloader').load("lsp/configs")
end
return M
