-- TODO: https://github.com/nvim-telescope/telescope-frecency.nvim
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      local builtin = require("telescope.builtin")

      -- file-related bindings
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
      vim.keymap.set("n", "<leader>fgS", builtin.git_status, { desc = "Find in git modified files vs HEAD" })

      -- grep-related bindings
      vim.keymap.set("n", "<leader>fg", builtin.current_buffer_fuzzy_find, { desc = "Grep current buffer" })
      vim.keymap.set("n", "<leader>fG", builtin.live_grep, { desc = "Grep all files" })
      vim.keymap.set("n", "<leader>f*", builtin.grep_string, { desc = "Grep all files (with current word)" })

      -- lsp-related bindings
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find references (LSP)" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find symbols in current buffer (LSP)" })
      vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Find symbols in workspace (LSP)" })

      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find mapped keys" })
    end,
  },
  {
    "princejoogie/dir-telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("dir-telescope").setup()
    end,
    init = function()
      require("telescope").load_extension("dir")
      vim.keymap.set("n", "<leader>fdg", "<cmd>Telescope dir live_grep<CR>", { desc = "Grep all files in directory" })
      vim.keymap.set("n", "<leader>fdf", "<cmd>Telescope dir find_files<CR>", { desc = "Find files in directory" })
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*",
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require("telescope").load_extension("frecency")
      local frecency = require("telescope").extensions.frecency
      vim.keymap.set("n", "<leader>fR", frecency.frecency, { desc = "Recent files" })
    end,
  },
  {
    "mrloop/telescope-git-branch.nvim",
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require("telescope").load_extension("git_branch")
      vim.keymap.set("n", "<leader>fgs", "<cmd>Telescope git_branch<CR>", { desc = "Find in git modified files vs default branch" })
    end,
  },
}
