return {
  {
    "tpope/vim-dispatch",
    enabled = true,
    keys = {
      { "<leader>M", "<cmd>:Make<cr>", desc = "Dispatch: run make" },
      { "<leader>T", "<cmd>:Make test<cr>", desc = "Dispatch: run make test" },
    },
    config = function()
    end,
  }
}
