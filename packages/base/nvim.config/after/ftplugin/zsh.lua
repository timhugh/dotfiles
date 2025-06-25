vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'zsh' },
  callback = function() vim.treesitter.start() end,
})
