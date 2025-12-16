return {
  {
    'stevearc/oil.nvim',
    enabled = true,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.keymap.set("n", "<leader>p", ":wincmd t | vsplit | wincmd h | wincmd H | Oil<CR>", { desc = "[Oil] Open to far left" })
      vim.keymap.set("n", "<leader>o", require("oil").open_float, { desc = "[Oil] Open in floating window" })
      vim.keymap.set("n", "-", require("oil").open, { desc = "[Oil] Open in current buffer" })
      vim.keymap.set("n", "_", require("oil.actions").open_cwd.callback, { desc = "[Oil] Open in current working directory" })
    end,
    opts = {
      win_options = {
        signcolumn = "yes:2",
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-->"] = { "actions.select", opts = { horizontal = true } },
        ["<C-s>"] = false,
        ["<C-\\>"] = { "actions.select", opts = { vertical = true } },
      },
    },
  },
  {
    "refractalize/oil-git-status.nvim",
    enabled = true,
    dependencies = {
      "stevearc/oil.nvim",
    },
    opts = {},
  },
  {
    "JezerM/oil-lsp-diagnostics.nvim",
    enabled = true,
    dependencies = { "stevearc/oil.nvim" },
    opts = {}
  },
}
