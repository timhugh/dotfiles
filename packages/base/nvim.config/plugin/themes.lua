vim.pack.add({
  'https://github.com/gosukiwi/vim-atom-dark',
  'https://github.com/EdenEast/nightfox.nvim',
  'https://github.com/olimorris/onedarkpro.nvim',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/catppuccin/nvim',
  'https://github.com/Mofiqul/vscode.nvim',
  'https://github.com/projekt0n/github-nvim-theme',
})

require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/f-person/auto-dark-mode.nvim',
  })

  require('auto-dark-mode').setup({
    update_interval = 1000,
    set_dark_mode = function()
      vim.opt.background = "dark"
      vim.cmd("colorscheme carbonfox")
    end,
    set_light_mode = function()
      vim.opt.background = "light"
      vim.cmd("colorscheme onelight")
    end,
  })
end)
