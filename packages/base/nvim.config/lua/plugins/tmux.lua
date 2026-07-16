return {
  {
    "alexghergh/nvim-tmux-navigation",
    enabled = true,
    keys = {
      { "<M-h>", "<cmd>NvimTmuxNavigateLeft<cr>",  desc = "Go to left pane" },
      { "<M-j>", "<cmd>NvimTmuxNavigateDown<cr>",  desc = "Go to lower pane" },
      { "<M-k>", "<cmd>NvimTmuxNavigateUp<cr>",    desc = "Go to upper pane" },
      { "<M-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Go to right pane" },
    },
    opts = {},
  }
}
