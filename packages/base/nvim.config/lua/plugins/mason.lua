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
        "rust_analyzer",
        "tailwindcss",
        "taplo",
        "ts_ls",
        "yamlls",
      },
    },
  },
}
