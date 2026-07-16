return {
  {
    "sindrets/winshift.nvim",
    enabled = true,
    event = "VeryLazy",
    cmd = "WinShift",
    keys = {
      { "<leader>ws",   "<cmd>WinShift<cr>",         desc = "Winshift" },
      { "<leader>wx",   "<cmd>WinShift swap<cr>",    desc = "Winshift: swap windows" },
      { "<c-m-h>",      "<cmd>WinShift left<cr>",    desc = "Winshift: move window left" },
      { "<c-m-j>",      "<cmd>WinShift down<cr>",    desc = "Winshift: move window down" },
      { "<c-m-k>",      "<cmd>WinShift up<cr>",      desc = "Winshift: move window up" },
      { "<c-m-l>",      "<cmd>WinShift right<cr>",   desc = "Winshift: move window right" },
    },
    opts = {},
  },
}
