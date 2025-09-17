vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false

-- vim.api.nvim_create_user_command('RailsRoutes', 'tabnew | r !bin/rails routes')
vim.keymap.set("n", "<leader>gv", "<cmd>:Eview<cr>", { desc = "(Rails) Navigate to view" })
vim.keymap.set("n", "<leader>tgv", "<cmd>:Tview<cr>", { desc = "(Rails) New tab at view" })
vim.keymap.set("n", "<leader>xgv", "<cmd>:Sview<cr>", { desc = "(Rails) New hsplit at view" })
vim.keymap.set("n", "<leader>vgv", "<cmd>:Vview<cr>", { desc = "(Rails) New vsplit at view" })
vim.keymap.set("n", "<leader>gc", "<cmd>:Econtroller<cr>", { desc = "(Rails) Navigate to controller" })
vim.keymap.set("n", "<leader>tgc", "<cmd>:Tcontroller<cr>", { desc = "(Rails) New tab at controller" })
vim.keymap.set("n", "<leader>xgc", "<cmd>:Scontroller<cr>", { desc = "(Rails) New hsplit at controller" })
vim.keymap.set("n", "<leader>vgc", "<cmd>:Vcontroller<cr>", { desc = "(Rails) New vsplit at controller" })

vim.lsp.enable('ruby_lsp')
-- vim.lsp.enable('solargraph')
-- vim.lsp.enable('sorbet')
-- vim.lsp.enable('standardrb')
vim.lsp.enable('rubocop')
