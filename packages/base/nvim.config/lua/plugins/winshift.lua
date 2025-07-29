return {
  {
    "sindrets/winshift.nvim",
    enabled = true,
    event = "VeryLazy",
    cmd = "WinShift",
    keys = {
      { "<leader>ws", "<cmd>WinShift<cr>", desc = "Window Shift" },
      { "<leader>wx", "<cmd>WinShift swap<cr>", desc = "Window Swap" },
    },
    opts = {},
  },
}
