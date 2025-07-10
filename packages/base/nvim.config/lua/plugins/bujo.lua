return {
  {
    dir = "~/git/bujo.nvim",
    enabled = true,
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "leafo/etlua",
    },
    opts = {
      base_directory = "~/.journal",
      spreads = {
        template = "weekly-entry.etlua",
        iteration_max_steps = 8,
      },
      picker = {
        open_keybind = "<leader>fn",
      },
      git = {
        auto_commit = true,
        auto_push = true,
      },
      markdown = {
        execute_code_block_keybind = "<leader>rb",
      },
    },
    config = function(_, opts)
      require("bujo").setup(opts)

      require("telescope").load_extension("bujo")
    end,
  },
}
