return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            lsp_zero.setup()

            lsp_zero.on_attach(function(_, bufnr)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
                    buffer = bufnr,
                    desc = "Go to definition",
                })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
                    buffer = bufnr,
                    desc = "Go to declaration",
                })
                vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {
                    buffer = bufnr,
                    desc = "Go to implementation",
                })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, {
                    buffer = bufnr,
                    desc = "Go to references",
                })
            end)

            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require('lspconfig')

            mason.setup()

            mason_lspconfig.setup({
                ensure_installed = {
                    "angularls",
                    "bashls",
                    "clangd",
                    "cmake",
                    "cssls",
                    "gopls",
                    "html",
                    "lua_ls",
                    "ruby_lsp",
                    "standardrb",
                    "tailwindcss",
                    "tsserver",
                    "yamlls",
                },
                handlers = {
                    lsp_zero.default_setup,
                    ["lua_ls"] = function ()
                        lspconfig.lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        })
                    end,
                    ["bashls"] = function ()
                        lspconfig.bashls.setup({
                            filetypes = { 'bash', 'zsh' }
                        })
                    end,
                },
            })
        end
    },
}
