local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- remove search highlighting
keymap("n", "<leader>/", "<Esc>:noh<CR>", opts)

-- restart neovim
keymap("n", "<leader>R", "<cmd>lua require('vscode').action('vscode-neovim.restart')<CR>", opts)

-- editor navigation
keymap("n", "<leader>t", "<cmd>lua require('vscode').action('workbench.action.createTerminalEditor')<CR>", opts)
keymap("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
keymap("n", "<leader>fG", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", opts)
keymap("n", "<leader>fp", "<cmd>lua require('vscode').action('workbench.action.openRecent')<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('vscode').action('git.openAllChanges')<CR>", opts)
keymap("n", "<leader>fr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", opts)
keymap("n", "<leader>r", "<cmd>lua require('vscode').action('editor.action.rename')<CR>", opts)
keymap("n", "<leader>q", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>", opts)
keymap("n", "<leader>o", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>", opts)
keymap("n", "<leader>O", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>", opts)
keymap("n", "<leader>z", "<cmd>lua require('vscode').action('workbench.action.toggleZenMode')<CR>", opts)

-- copying paths
keymap("n", "<leader>y", "<cmd>lua require('vscode').action('copyRelativeFilePath')<CR>", opts)
keymap("n", "<leader>gy", "<cmd>lua require('vscode').action('issue.copyGithubPermalink')<CR>", opts)

-- git
keymap("n", "<leader>gb", "<cmd>lua require('vscode').action('gitlens.toggleFileBlame')<CR>", opts)
keymap("n", "<leader>gh", "<cmd>lua require('vscode').action('git-blame.command.fileHistory')<CR>", opts)
keymap("n", "<leader>gl", "<cmd>lua require('vscode').action('git-blame.command.lineHistory')<CR>", opts)

-- debugger
keymap("n", "<leader>dl", "<cmd>lua require('vscode').action('extension.js-debug.debugLink')<CR>", opts)
keymap("n", "<leader>dd", "<cmd>lua require('vscode').action('workbench.action.debug.start')<CR>", opts)
keymap("n", "<leader>db", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>", opts)
keymap("n", "<leader>dc", "<cmd>lua require('vscode').action('editor.debug.action.clearBreakpoints')<CR>", opts)
keymap("n", "<leader>dr", "<cmd>lua require('vscode').action('editor.debug.action.restart')<CR>", opts)
keymap("n", "<leader>ds", "<cmd>lua require('vscode').action('editor.debug.action.stepOver')<CR>", opts)
keymap("n", "<leader>di", "<cmd>lua require('vscode').action('editor.debug.action.stepInto')<CR>", opts)
keymap("n", "<leader>do", "<cmd>lua require('vscode').action('editor.debug.action.stepOut')<CR>", opts)

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