return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      auto_install = true,
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "cmake",
          "cssls",
          "eslint",
          "golangci_lint_ls",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "rubocop",
          "ruby_lsp",
          "solargraph",
          "sorbet",
          "standardrb",
          "tailwindcss",
          "taplo",
          "yamlls",
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function()
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
        vim.keymap.set("n", "gen", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
        vim.keymap.set("n", "gep", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })
        vim.keymap.set("n", "<leader>ih", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle inlay hints" })
      end

      local lspconfig = require("lspconfig")
      lspconfig.bashls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'bash', 'zsh' },
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      -- lspconfig.sorbet.setup({
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup()
    end,
  },
}
