return {
  {
    "tpope/vim-dispatch",
    enabled = true,
    cmd = "Dispatch",
    keys = {
      { "<leader>M", "<cmd>:Make<cr>",      desc = "Dispatch: make" },
      { "<leader>T", "<cmd>:Make test<cr>", desc = "Dispatch: test" },
      { "<leader>R", "<cmd>:Make run<cr>",  desc = "Dispatch: run" },
    },
    config = function()
    end,
  }
}
