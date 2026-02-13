return {
  {
    -- dir = "~/git/bujo.nvim",
    "timhugh/bujo.nvim",
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "leafo/etlua",
    },
    keys = {
      { "<leader>ngp", "<cmd>lua require('bujo.git').pull()<cr>", desc = "Bujo: Git pull" },
      { "<leader>ngP", "<cmd>lua require('bujo.git').push()<cr>", desc = "Bujo: Git push" },
      { "<leader>ngc", "<cmd>lua require('bujo.git').commit()<cr>", desc = "Bujo: Git commit" },
    },
    opts = {
      base_directory = "~/.journal",
      spreads = {
        weekly = {
          filename_template = "spreads/%Y/W%V",
          template = "weekly-spread.etlua",
        },
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
