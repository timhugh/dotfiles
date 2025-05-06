return {
  {
    "tpope/vim-rails",
    keys = {
      { "<leader>gv", "<cmd>:Eview<cr>", desc = "(Rails) Navigate to view" },
      { "<leader>tgv", "<cmd>:Tview<cr>", desc = "(Rails) New tab at view" },
      { "<leader>xgv", "<cmd>:Sview<cr>", desc = "(Rails) New hsplit at view" },
      { "<leader>vgv", "<cmd>:Vview<cr>", desc = "(Rails) New vsplit at view" },

      { "<leader>gc", "<cmd>:Econtroller<cr>", desc = "(Rails) Navigate to controller" },
      { "<leader>tgc", "<cmd>:Tcontroller<cr>", desc = "(Rails) New tab at controller" },
      { "<leader>xgc", "<cmd>:Scontroller<cr>", desc = "(Rails) New hsplit at controller" },
      { "<leader>vgc", "<cmd>:Vcontroller<cr>", desc = "(Rails) New vsplit at controller" },
    },
    ft = "ruby",
  },
}
