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
      entries_template = "weekly-entry.etlua",
      telescope_picker_keybind = "<leader>fn",
      auto_commit_journal = true,
      auto_push_journal = true,
    },
    config = function(_, opts)
      require("bujo").setup(opts)

      require("telescope").load_extension("bujo")
    end,
  },
}
