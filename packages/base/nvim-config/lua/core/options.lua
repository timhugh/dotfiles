vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = { "longest", "list" }

vim.opt.cursorline = true

vim.opt.termguicolors = true

-- use treesitter for folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
-- syntax highlight fold start line
vim.opt.foldtext = ""
-- start with most folds closed
-- (2 leaves space for a namespace and a class name in most languages)
vim.opt.foldlevelstart = 2
-- don't fold more than 4 levels deep
vim.opt.foldnestmax = 4

