vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.wrap = false

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gd' },
  callback = function() vim.treesitter.start() end,
})
