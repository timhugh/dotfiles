return {
  {
    dir = "~/git/bujo.nvim",
    enabled = true,
    lazy = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "leafo/etlua",
    },
    keys = {
      { "<leader>nn", "<CMD>Bujo now<CR>", { desc = "Bujo: Open current week" } },
      { "<leader>nN", "<CMD>Bujo note<CR>", { desc = "Bujo: Create new note" } },
      { "<leader>fn", "<CMD>Telescope bujo<CR>", { desc = "Bujo: Open note picker" } },
    },
    opts = {
      entries_template = "weekly-entry.etlua",
    },
    config = function(_, opts)
      require("bujo").setup(opts)

      require("telescope").load_extension("bujo")
    end,
  },
}
