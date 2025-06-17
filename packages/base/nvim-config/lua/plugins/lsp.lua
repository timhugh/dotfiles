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

          -- java
          "jdtls",

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
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local gitsigns = require("gitsigns")

      local function format_changed_hunks()
        local hunks = gitsigns.get_hunks()

        if not hunks then
          vim.notify("No changed hunks found", vim.log.levels.WARN)
          return
        end

        for _, hunk in ipairs(hunks) do
          if hunk.added.count > 0 then
            local start_line = hunk.added.start - 1
            local end_line = start_line + hunk.added.count
            vim.lsp.buf.format({
              range = {
                start = { start_line, 0 },
                ["end"] = { end_line, 0 },
              },
            })
          end
        end
      end

      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentRangeFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = format_changed_hunks,
          })
        end

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
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
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
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = on_attach,
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
