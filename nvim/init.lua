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

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = { "longest", "list" }

vim.opt.cursorline = true

local lazy = {}

function lazy.install(path)
    if not (vim.uv or vim.loop).fs_stat(path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            path,
        })
    end
end

function lazy.setup(plugins)
    if vim.g.plugins_ready then
        return
    end

    lazy.install(lazy.path)

    vim.opt.rtp:prepend(lazy.path)

    require('lazy').setup(plugins, lazy.opts)
    vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
lazy.opts = {}
lazy.setup({
    {'folke/tokyonight.nvim'},
    {'doums/darcula'},
    {'joshdick/onedark.vim'},
    {'gosukiwi/vim-atom-dark'},

    {'nvim-lualine/lualine.nvim'},
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('atom-dark')

require('lualine').setup()


