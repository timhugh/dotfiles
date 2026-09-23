require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/sindrets/winshift.nvim',
  })

  require('winshift').setup()

  vim.keymap.set('n', '<c-m-h>', '<cmd>WinShift left<cr>', { desc = 'winshift: move window left' })
  vim.keymap.set('n', '<c-m-j>', '<cmd>WinShift down<cr>', { desc = 'winshift: move window down' })
  vim.keymap.set('n', '<c-m-k>', '<cmd>WinShift up<cr>', { desc = 'winshift: move window up' })
  vim.keymap.set('n', '<c-m-l>', '<cmd>WinShift right<cr>', { desc = 'winshift: move window right' })
end)
