vim.g.mapleader = ","

-- quick exit to normal mode
vim.keymap.set('i', 'jj', '<ESC>')

-- window movement
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-- clear highlights after searching
vim.keymap.set('n', '<leader>/', '<cmd>:nohlsearch<cr>')

-- TODO: this should only be enabled in c/c++ files
vim.keymap.set('n', '<leader>h', '<cmd>:ClangdSwitchSourceHeader<cr>')

