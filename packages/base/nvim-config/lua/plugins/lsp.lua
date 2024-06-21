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

            lsp_zero.on_attach(function(_, buffer)
                lsp_zero.default_keymaps({ buffer = buffer })
            end)

            lsp_zero.configure("lua_ls", {
                settings = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            })

            lsp_zero.setup()

            lsp_zero.on_attach(function(_, buffer)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
                    buffer = buffer,
                    desc = "Go to definition",
                })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
                    buffer = buffer,
                    desc = "Go to declaration",
                })
                vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {
                    buffer = buffer,
                    desc = "Go to implementation",
                })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, {
                    buffer = buffer,
                    desc = "Go to references",
                })
            end)

            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            mason.setup()

            mason_lspconfig.setup({
                ensure_installed = {
                    "tsserver",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "lua_ls",
                    "gopls",
                    "clangd",
                    "solargraph",
                    "standardrb"
                },
                handlers = {
                    lsp_zero.default_setup,
                },
            })
        end
    },
}
