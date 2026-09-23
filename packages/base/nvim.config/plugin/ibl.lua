require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/lukas-reineke/indent-blankline.nvim',
  })

  require('ibl').setup()
end)
