vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'bash' },
  callback = function() vim.treesitter.start() end,
})
