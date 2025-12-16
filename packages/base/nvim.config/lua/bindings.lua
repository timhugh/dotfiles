vim.g.mapleader = ","

-- split shortcuts
vim.keymap.set("n", "<leader>-", "<cmd>:split<cr>")

vim.keymap.set("n", "<leader>\\", "<cmd>:vsplit<cr>")

-- tab shortcuts
vim.keymap.set("n", "<c-t>", "<cmd>:tabnew %<cr>")
vim.keymap.set("n", "<c-m-t>", "<cmd>:tabnew | terminal<cr>")

-- open terminal
vim.keymap.set("n", "<leader>t", "<cmd>:terminal<cr>")
--
-- exit terminal mode
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>")

-- navigating splits
vim.keymap.set("n", "<m-h>", "<c-w>h")
vim.keymap.set("t", "<m-h>", "<c-\\><c-n><c-w>h")

vim.keymap.set("n", "<m-j>", "<c-w>j")
vim.keymap.set("t", "<m-j>", "<c-\\><c-n><c-w>j")

vim.keymap.set("n", "<m-k>", "<c-w>k")
vim.keymap.set("t", "<m-k>", "<c-\\><c-n><c-w>k")

vim.keymap.set("n", "<m-l>", "<c-w>l")
vim.keymap.set("t", "<m-l>", "<c-\\><c-n><c-w>l")

-- clear highlights after searching
vim.keymap.set("n", "<leader>/", "<cmd>:nohlsearch<cr>")

-- show messages
vim.keymap.set("n", "<leader>m", "<cmd>:messages<cr>")

-- omni-omnifunc
vim.keymap.set("i", "<c-n>", function()
  if vim.fn.pumvisible() == 1 then return "<c-n>" else return "<c-x><c-o>" end
end, { expr = true, desc = "Trigger omnifunc or select next item in completion menu" })

-- copy path to clipboard
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
