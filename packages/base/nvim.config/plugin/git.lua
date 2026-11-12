require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/lewis6991/gitsigns.nvim',
  })

  require('gitsigns').setup()

  vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<cr>', { desc = 'gitsigns: preview hunk' })
  vim.keymap.set('n', ']g', ':Gitsigns next_hunk<cr>', { desc = 'gitsigns: next hunk' })
  vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<cr>', { desc = 'gitsigns: previous hunk' })
  vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<cr>', { desc = 'gitsigns: toggle blame' })
  vim.keymap.set('n', '<leader>gR', ':Gitsigns reset_hunk<cr>', { desc = 'gitsigns: reset hunk' })
  vim.keymap.set('n', '<leader>gs', ':Gitsigns stage_hunk<cr>', { desc = 'gitsigns: stage hunk' })
  vim.keymap.set('n', '<leader>gu', ':Gitsigns undo_stage_hunk<cr>', { desc = 'gitsigns: unstage hunk' })
  vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<cr>', { desc = 'gitsigns: diff file' })
end)
