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
      automatic_enable = {
        exclude = { "astro" },
      },
      ensure_installed = {
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
        -- managing kotlin_lsp externally:
        -- "kotlin_lsp",
        "lua_ls",
        "markdown_oxide",
        "pylsp",
        -- "rubocop",
        "ruby_lsp",
        "rust_analyzer",
        -- "sorbet",
        -- "standardrb",
        "tailwindcss",
        "taplo",
        "templ",
        "ts_ls",
        "yamlls",
        "zls",
      },
    },
    config = function(_, opts)
      local typescript_root = vim.fn.system({ "mise", "where", "npm:typescript@6.0.3" }):gsub("%s+$", "")
      vim.lsp.config('astro', {
        cmd = { "mise", "x", "npm:@astrojs/language-server@2.16.13", "--", "astro-ls", "--stdio" },
        before_init = function(_, config)
          config.init_options.typescript.tsdk = typescript_root .. "/node_modules/typescript/lib"
        end,
      })
      vim.lsp.enable('astro')

      require("mason-lspconfig").setup(opts)

      vim.lsp.enable('gdscript')
      vim.lsp.config('kotlin_lsp', {
        cmd = { "kotlin-lsp", "--stdio" },
        filetypes = { "kotlin" },
        root_markers = { "settings.gradle", "settings.gradle.kts", "pom.xml", "build.gradle", "build.gradle.kts", "workspace.json" },
      })
      vim.lsp.enable('kotlin_lsp')
    end,
  },
  {
    "RubixDev/mason-update-all",
    enabled = true,
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {},
    config = function(_, opts)
      require("mason-update-all").setup(opts)

      -- vim.api.nvim_create_autocmd('User', {
      --   pattern = 'MasonUpdateAllComplete',
      --   callback = function()
      --     print('mason-update-all has finished')
      --   end,
      -- })
    end,
  },
}
