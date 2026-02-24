local M = {}

M.javascript = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.expandtab = false
  vim.opt_local.autoindent = true
  vim.opt_local.wrap = false

  if not vim.b.neoformat_on_save then
    vim.b.neoformat_on_save = 1
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = 0,
      callback = function()
        vim.cmd('Neoformat')
      end,
    })
  end
end

return M
