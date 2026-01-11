return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      -- file related bindings
      { "<leader>fb",  "<cmd>Telescope buffers<CR>",                   desc = "[Telescope] Find buffers" },
      { "<leader>ff",  "<cmd>Telescope find_files<CR>",                desc = "[Telescope] Find file" },
      { "<leader>fgs", "<cmd>Telescope git_status<CR>",                desc = "[Telescope] Find in git modified files vs HEAD" },

      -- grep related bindings
      { "<leader>fg",  "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "[Telescope] Grep current buffer" },
      { "<leader>fG",  "<cmd>Telescope live_grep<CR>",                 desc = "[Telescope] Grep all files" },
      { "<leader>f*",  "<cmd>Telescope grep_string<CR>",               desc = "[Telescope] Grep all files (with current word)" },

      -- lsp related bindings
      { "<leader>fr",  "<cmd>Telescope lsp_references<CR>",            desc = "[Telescope] Find references (LSP)" },
      { "<leader>fs",  "<cmd>Telescope lsp_document_symbols<CR>",      desc = "[Telescope] Find symbols in current buffer (LSP)" },
      { "<leader>fS",  "<cmd>Telescope lsp_workspace_symbols<CR>",     desc = "[Telescope] Find symbols in workspace (LSP)" },
      { "<leader>fD",  "<cmd>Telescope diagnostics<CR>",               desc = "[Telescope] Find diagnostics (LSP)" },

      -- other
      { "<leader>fk",  "<cmd>Telescope keymaps<CR>",                   desc = "[Telescope] Find mapped keys" },
      { "<leader>ft",  "<cmd>Telescope builtin<CR>",                   desc = "[Telescope] Find builtin commands" },
      { "<leader>fh",  "<cmd>Telescope command_history<CR>",           desc = "[Telescope] Find command history" },
    },
  },
  {
    "princejoogie/dir-telescope.nvim",
    enabled = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>fdg", "<cmd>Telescope dir live_grep<CR>", desc = "Grep all files in directory" },
      { "<leader>fdf", "<cmd>Telescope dir find_files<CR>", desc = "Find files in directory" },
    },
    init = function()
      require("telescope").load_extension("dir")
    end,
    opts = {
      hidden = false,
      no_ignore = false,
      show_preview = true,
      follow_symlinks = false,
    }
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    enabled = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { "<leader>fR", "<cmd>Telescope frecency<CR>", desc = "Recent files" },
    },
    init = function()
      require("telescope").load_extension("frecency")
    end,
  },
  {
    "mrloop/telescope-git-branch.nvim",
    enabled = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { "<leader>fgS", "<cmd>Telescope git_branch<CR>", desc = "Find in git modified files vs default branch" },
    },
    init = function()
      require("telescope").load_extension("git_branch")
    end,
  },
}
