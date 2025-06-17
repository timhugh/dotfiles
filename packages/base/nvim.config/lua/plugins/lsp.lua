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
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "eslint",
        "glslls",
        "golangci_lint_ls",
        "gopls",
        "html",
        "jdtls",
        "jsonls",
        "lua_ls",
        "nginx_language_server",
        "pylsp",
        -- "rubocop",
        "ruby_lsp",
        "rust_analyzer",
        -- "solargraph",
        -- "sorbet",
        "standardrb",
        "tailwindcss",
        "taplo",
        "yamlls",
      },
    },
  },
}
