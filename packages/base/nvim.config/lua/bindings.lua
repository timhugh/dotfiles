vim.g.mapleader = ","

vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>")
vim.keymap.set("n", "<leader>M", "<cmd>:Mason<cr>")

vim.keymap.set("n", "<c-->", "<cmd>:split<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>:vsplit<cr>")
vim.keymap.set("n", "<c-t>", "<cmd>:tabnew %<cr>")

-- exit terminal mode
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>")

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
