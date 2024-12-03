return {
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "Preview current hunk" })
    end
  },
  {
    "FabijanZulj/blame.nvim",
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Toggle git blame" }
    },
    config = function()
      require("blame").setup()
    end
  }
}
