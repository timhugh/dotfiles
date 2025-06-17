vim.g.mapleader = ","

-- split shortcuts
vim.keymap.set("n", "<c-->", "<cmd>:split<cr>")
vim.keymap.set("n", "<leader>-", "<cmd>:split<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>:vsplit<cr>")
vim.keymap.set("n", "<leader>\\", "<cmd>:vsplit<cr>")

-- open blank tab
vim.keymap.set("n", "<c-t>", "<cmd>:tabnew<cr>")

-- open terminal
vim.keymap.set("n", "<leader>t", "<cmd>:terminal<cr>")
vim.keymap.set("n", "<leader>t\\", "<cmd>:vsplit | wincmd l | terminal<cr>")
vim.keymap.set("n", "<leader>t-", "<cmd>:split | wincmd j | terminal<cr>")

-- navigating splits
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- clear highlights after searching
vim.keymap.set("n", "<leader>/", "<cmd>:nohlsearch<cr>")

-- toggle wrap
vim.keymap.set("n", "<leader>w", "<cmd>:set wrap!<cr>")

-- copy path to clipboard
vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.keymap.set("n", "<leader>y", "<cmd>:Cppath<cr>")

-- exit terminal mode
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>")
