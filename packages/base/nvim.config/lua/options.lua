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

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.colorcolumn = "120"

-- settings for terminal buffers
vim.api.nvim_command("autocmd TermOpen * startinsert")
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber nospell")
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")

-- inline diagnostics
vim.diagnostic.config({
    virtual_text = true,
})

-- fuzzy omnifunc
if vim.fn.exists("&autocomplete") == 1 then
    vim.opt.autocomplete = true
end
vim.opt.completeopt = { "fuzzy", "menuone", "noinsert", "popup" }

