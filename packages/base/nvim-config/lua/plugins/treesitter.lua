return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "c",
                "cpp",
                "css",
                "dockerfile",
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
    end
}

