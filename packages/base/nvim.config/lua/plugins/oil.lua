return {
  {
    'stevearc/oil.nvim',
    enabled = true,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.keymap.set("n", "<leader>P", require("oil").open, { desc = "Open Oil" })
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open Oil" })
    end,
    opts = {
      win_options = {
        signcolumn = "yes:2",
      },
    },
  },
  {
    "refractalize/oil-git-status.nvim",
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = true,
  },
  {
    "JezerM/oil-lsp-diagnostics.nvim",
    dependencies = { "stevearc/oil.nvim" },
    opts = {}
  },
}
