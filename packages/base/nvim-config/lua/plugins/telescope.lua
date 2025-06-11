return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      -- file related bindings
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find file" },
      { "<leader>fgS", "<cmd>Telescope git_status<CR>", desc = "Find in git modified files vs HEAD" },

      -- grep related bindings
      { "<leader>fg", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Grep current buffer" },
      { "<leader>fG", "<cmd>Telescope live_grep<CR>", desc = "Grep all files" },
      { "<leader>f*", "<cmd>Telescope grep_string<CR>", desc = "Grep all files (with current word)" },

      -- lsp related bindings
      { "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "Find references (LSP)" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Find symbols in current buffer (LSP)" },
      { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Find symbols in workspace (LSP)" },

      -- other
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find mapped keys" },
    },
  },
  {
    "princejoogie/dir-telescope.nvim",
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
    version = "*",
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
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { "<leader>fgs", "<cmd>Telescope git_branch<CR>", desc = "Find in git modified files vs default branch" },
    },
    init = function()
      require("telescope").load_extension("git_branch")
    end,
  },
}
