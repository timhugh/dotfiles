vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = { "longest", "list" }
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.g.editorconfig = true

vim.opt.colorcolumn = "120"

vim.opt.splitright = true
vim.opt.splitbelow = true

-- settings for terminal buffers
vim.api.nvim_command("autocmd TermOpen * startinsert")
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber nospell")
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")

-- inline diagnostics
vim.diagnostic.config({
    virtual_text = true,
})

-- fuzzy omnifunc
vim.opt.completeopt = { "fuzzy", "menuone", "noinsert", "popup" }
