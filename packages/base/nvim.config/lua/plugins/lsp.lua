return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
  },
  {
    "williamboman/mason.nvim",
    enabled = true,
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = true,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = true,
      ensure_installed = {
        "astro",
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "glsl_analyzer",
        "golangci_lint_ls",
        "gopls",
        "html",
        "jdtls",
        "jsonls",
        "kotlin_lsp",
        "lua_ls",
        "pylsp",
        "rubocop",
        "ruby_lsp",
        "rust_analyzer",
        "sorbet",
        "standardrb",
        "tailwindcss",
        "taplo",
        "templ",
        "ts_ls",
        "yamlls",
        "zls",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      vim.lsp.enable('gdscript')
    end,
  },
}
