vim.g.mapleader = ","

-- quick exit to normal mode
vim.keymap.set("i", "jj", "<ESC>")

-- split shortcuts
vim.keymap.set("n", "<c-->", "<cmd>:split<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>:vsplit<cr>")

-- open blank tab
vim.keymap.set("n", "<c-t>", "<cmd>:tabnew<cr>")

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

