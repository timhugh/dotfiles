return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      vim.keymap.set("n", "<leader>ftd", "<cmd>TodoTelescope<cr>", { desc = "todo-comments: Open telescope picker" }),
      vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo<cr>", { desc = "todo-comments: Open trouble list" }),
      vim.keymap.set("n", "<leader>qt", "<cmd>TodoQuickFix<cr>", { desc = "todo-comments: Open quickfix list" }),
      vim.keymap.set("n", "<leader>lt", "<cmd>TodoLocList<cr>", { desc = "todo-comments: Open location list" }),
    }
  }
}
