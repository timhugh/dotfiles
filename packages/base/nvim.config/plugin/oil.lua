vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/refractalize/oil-git-status.nvim',
  'https://github.com/JezerM/oil-lsp-diagnostics.nvim',
})

require('oil').setup({
  win_options = {
    signcolumn = 'yes:2',
  },
  keymaps = {
    ['<C-h>'] = false,
    ['<C-->'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-s>'] = false,
    ['<C-\\>'] = { 'actions.select', opts = { vertical = true } },
  },
})

vim.keymap.set('n', '-', require('oil').open, { desc = 'oil: open in current buffer' })
vim.keymap.set('n', '_', require('oil.actions').open_cwd.callback, { desc = 'oil: open in cwd' })

require('oil-git-status').setup()
require('oil-lsp-diagnostics').setup()
