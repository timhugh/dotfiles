require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/stevearc/overseer.nvim',
  })

  require('overseer').setup()

  vim.keymap.set('n', '<leader>r', '<cmd>OverseerRun<cr>', { desc = 'overseer: run' })
  vim.keymap.set('n', '<leader>R', '<cmd>OverseerToggle<cr>', { desc = 'overseer: toggle' })
end)
