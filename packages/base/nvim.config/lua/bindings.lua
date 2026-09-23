vim.g.mapleader = ","

vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>")
vim.keymap.set("n", "<leader>M", "<cmd>:Mason<cr>")

vim.keymap.set("n", "<c-->", "<cmd>:split<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>:vsplit<cr>")
vim.keymap.set("n", "<c-t>", "<cmd>:tabnew %<cr>")

vim.keymap.set("n", "<m-h>", "<c-w>h")
vim.keymap.set("n", "<m-j>", "<c-w>j")
vim.keymap.set("n", "<m-k>", "<c-w>k")
vim.keymap.set("n", "<m-l>", "<c-w>l")
vim.keymap.set("t", "<m-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<m-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<m-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<m-l>", "<c-\\><c-n><c-w>l")
vim.keymap.set("n", "<leader>t", ":vsplit | terminal<cr>")
vim.keymap.set("t", "<esc>", "<c-\\><c-n>")

-- clear highlights after searching
vim.keymap.set("n", "<leader>/", "<cmd>:nohlsearch<cr>")

-- show messages
vim.keymap.set("n", "<leader>m", "<cmd>:messages<cr>")

vim.api.nvim_create_user_command("CopyProjectPath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.keymap.set("n", "<leader>y", "<cmd>:CopyProjectPath<cr>")
vim.keymap.set("n", "<leader>Y", "<cmd>:CopyAbsolutePath<cr>")
