return {
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {},
      }
    },
    opts = {
      ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "eslint",
        "glsl_analyzer",
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
