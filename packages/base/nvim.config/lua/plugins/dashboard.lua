return {
  {
    'nvimdev/dashboard-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    event = 'VimEnter',
    keys = {
      { '<leader>H', '<cmd>Dashboard<cr>', desc = 'Open Dashboard' },
    },
    opts = {
      theme = 'hyper',
      config = {
        packages = {
          enable = false,
        },
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            icon = '',
            desc = 'New file',
            group = 'DashboardShortCut',
            action = 'enew',
            key = 'N',
          },
          {
            icon = '',
            desc = 'Edit dotfiles',
            group = 'DashboardShortCut',
            action = 'cd ~/.dotfiles | edit .',
            key = 'D',
          },
          {
            icon = '',
            desc = 'Journal',
            group = 'DashboardShortCut',
            action = 'Bujo now',
            key = 'J',
          },
        },
      },
    },
  },
}
