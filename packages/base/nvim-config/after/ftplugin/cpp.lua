vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.wrap = false

vim.keymap.set("n", "<leader>cb", ":CMakeBuild<CR>", { desc = "Build CMake project" })
vim.keymap.set("n", "<leader>cr", ":CMakeRun<CR>", { desc = "Run CMake project" })
vim.keymap.set("n", "<leader>cC", ":CMakeClean<CR>", { desc = "Clean CMake project" })
vim.keymap.set("n", "<leader>ct", ":CMakeRunTest<CR>", { desc = "Run CMake project tests" })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp' },
  callback = function() vim.treesitter.start() end,
})
