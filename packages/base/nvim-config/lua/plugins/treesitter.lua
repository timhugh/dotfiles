return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "c",
                "cpp",
                "css",
                "dockerfile",
                "gdscript",
                "gdshader",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "gowork",
                "graphql",
                "helm",
                "html",
                "http",
                "java",
                "javascript",
                "jq",
                "json",
                "kotlin",
                "ledger",
                "llvm",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "regex",
                "ruby",
                "scss",
                "sql",
                "ssh_config",
                "terraform",
                "toml",
                "tsv",
                "tsx",
                "typescript",
                "vim",
                "vue",
                "xml",
                "yaml",
            }
        })

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldlevel = 99
        -- syntax highlight fold start line
        vim.opt.foldtext = ""
        -- don't fold by default (overrides are in ftplugins)
        vim.opt.foldlevelstart = 99
        -- don't fold more than 4 levels deep
        vim.opt.foldnestmax = 4
    end
}

