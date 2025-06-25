vim.opt.wrap = true
vim.opt.conceallevel = 2

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'norg' },
  callback = function() vim.treesitter.start() end,
})
