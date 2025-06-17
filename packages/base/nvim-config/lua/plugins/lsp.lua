return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
      }
    },
    opts = {
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
    },
  },
}
