vim.opt.wrap = true
vim.opt.spell = true

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function() vim.treesitter.start() end,
})
