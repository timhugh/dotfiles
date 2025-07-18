return {
  {
    "tpope/vim-fugitive",
    enabled = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "Preview current hunk" })
      vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<cr>", { desc = "Jump to next hunk" })
      vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<cr>", { desc = "Jump to previous hunk" })
      vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_hunk<cr>", { desc = "Reset current hunk" })
      vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<cr>", { desc = "Stage current hunk" })
      vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<cr>", { desc = "Undo stage current hunk" })
      vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>", { desc = "Diff current file" })
    end
  },
  {
    "FabijanZulj/blame.nvim",
    enabled = true,
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Toggle git blame" }
    },
    opts = {},
  },
  {
    "ruifm/gitlinker.nvim",
    enabled = true,
    opts = {},
  },
}
