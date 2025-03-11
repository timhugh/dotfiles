local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- use system keyboard
-- keymap("n", "<leader>y", '"*y', opts)
-- keymap("n", "<leader>p", '"*p', opts)

-- remove search highlighting
keymap("n", "<leader>/", "<Esc>:noh<CR>", opts)

-- editor tools
-- keymap("n", "", "<cmd>lua require('vscode').action('')<CR>", opts)
keymap("n", "<leader>R", "<cmd>lua require('vscode').action('vscode-neovim.restart')<CR>", opts)
keymap("n", "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>", opts)
keymap("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
keymap("n", "<leader>fG", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('vscode').action('git.openAllChanges')<CR>", opts)
keymap("n", "<leader>r", "<cmd>lua require('vscode').action('editor.action.rename')<CR>", opts)

-- split navigation
keymap("n", "<leader>\\", "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>", opts)
keymap("n", "<leader>-", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>", opts)
keymap("n", "<C-h>", "<cmd>lua require('vscode').action('workbench.action.navigateLeft')<CR>", opts)
keymap("n", "<C-left>", "<cmd>lua require('vscode').action('workbench.action.navigateLeft')<CR>", opts)
keymap("n", "<C-j>", "<cmd>lua require('vscode').action('workbench.action.navigateDown')<CR>", opts)
keymap("n", "<C-down>", "<cmd>lua require('vscode').action('workbench.action.navigateDown')<CR>", opts)
keymap("n", "<C-k>", "<cmd>lua require('vscode').action('workbench.action.navigateUp')<CR>", opts)
keymap("n", "<C-up>", "<cmd>lua require('vscode').action('workbench.action.navigateUp')<CR>", opts)
keymap("n", "<C-l>", "<cmd>lua require('vscode').action('workbench.action.navigateRight')<CR>", opts)
keymap("n", "<C-right>", "<cmd>lua require('vscode').action('workbench.action.navigateRight')<CR>", opts)