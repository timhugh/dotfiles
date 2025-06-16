-- TODO: having to add language servers both to masong_lspconfig ensure_installed and also to the nvim-lspconfig
-- configured servers is repetitive at best. It looks like there are two potential approaches:
--
-- 1. mason_lspconfig has a setup_handlers function that can be used to give a generic setup implementation:
--
--     local lspconfig = require('lspconfig')
--     require('mason').setup({})
--     require('mason-lspconfig').setup({
--       ensure_installed = {'sumneko_lua', 'rust_analyzer'}
--     })
--
--     require('mason-lspconfig').setup_handlers({
--       function(server)
--         lspconfig[server].setup({})
--       end,
--     })
--
--    There's more about that in :h mason-lspconfig-automatic-server-setup
--
-- 2. mason_lspconfig has an automatic_installation option, which in theory will automatically install any 
--    language servers that are manually configured by nvim-lspconfig (I think that's the idea, anyway)
--
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
          -- bash/zsh
          "bashls",

          -- c/c++
          "clangd",
          "cmake",

          -- css
          "cssls",

          -- javascript
          "eslint",

          -- go
          "golangci_lint_ls",
          "gopls",

          -- html
          "html",

          -- json
          "jsonls",

          -- lua
          "lua_ls",

          -- openGL
          "glslls",

          -- perl
          "perlnavigator",

          -- python
          "pylsp",

          -- ruby
          "rubocop",
          "ruby_lsp",
          "solargraph",
          "sorbet",
          "standardrb",

          -- rust
          "rust_analyzer",

          -- tailwind
          "tailwindcss",

          "taplo",

          -- yaml
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
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = function()
          on_attach()

          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.cpp,*.hpp,*.c,*.h",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })

          vim.keymap.set("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch between source/header" })
        end,
        settings = {
          clangd = {
            onConfigChanged = "restart",
          },
        },
      })
      lspconfig.gdscript.setup({
        name = "godot",
        cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.glslls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.tailwindcss.setup({
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
      lspconfig.standardrb.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      -- lspconfig.sorbet.setup({
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function()
          on_attach()

          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.ts,*.tsx",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      })
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function()
          on_attach()

          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.js,*.jsx",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      })
      lspconfig.pylsp.setup({
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
