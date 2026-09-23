require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/lewis6991/gitsigns.nvim',
  })

  require('gitsigns').setup()

  vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<cr>', { desc = 'Preview current hunk' })
  vim.keymap.set('n', ']g', ':Gitsigns next_hunk<cr>', { desc = 'Jump to next hunk' })
  vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<cr>', { desc = 'Jump to previous hunk' })
  vim.keymap.set('n', '<leader>gR', ':Gitsigns reset_hunk<cr>', { desc = 'Reset current hunk' })
  vim.keymap.set('n', '<leader>gs', ':Gitsigns stage_hunk<cr>', { desc = 'Stage current hunk' })
  vim.keymap.set('n', '<leader>gu', ':Gitsigns undo_stage_hunk<cr>', { desc = 'Undo stage current hunk' })
  vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<cr>', { desc = 'Diff current file' })
end)
