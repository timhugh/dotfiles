local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- remove search highlighting
keymap("n", "<leader>/", "<Esc>:noh<CR>", opts)

-- editor tools
keymap("n", "<leader>R", "<cmd>lua require('vscode').action('vscode-neovim.restart')<CR>", opts)
keymap("n", "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>", opts)
keymap("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
keymap("n", "<leader>fG", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", opts)
keymap("n", "<leader>fr", "<cmd>lua require('vscode').action('workbench.action.openRecent')<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('vscode').action('git.openAllChanges')<CR>", opts)
keymap("n", "<leader>r", "<cmd>lua require('vscode').action('editor.action.rename')<CR>", opts)
keymap("n", "<leader>q", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>", opts)
keymap("n", "<leader>y", "<cmd>lua require('vscode').action('copyRelativeFilePath')<CR>", opts)
keymap("n", "<leader>o", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>", opts)
keymap("n", "<leader>O", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>", opts)
keymap("n", "<leader>z", "<cmd>lua require('vscode').action('workbench.action.toggleZenMode')<CR>", opts)

-- error navigation
keymap("n", "<leader>E", "<cmd>lua require('vscode').action('editor.action.marker.this')<CR>", opts)
keymap("n", "<leader>en", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>", opts)
keymap("n", "<leader>ep", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>", opts)

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

-- cmake
keymap("n", "<leader>cb", "<cmd>lua require('vscode').action('cmake.build')<CR>", opts)
keymap("n", "<leader>cr", "<cmd>lua require('vscode').action('cmake.launchTarget')<CR>", opts)
keymap("n", "<leader>cd", "<cmd>lua require('vscode').action('cmake.debugTarget')<CR>", opts)