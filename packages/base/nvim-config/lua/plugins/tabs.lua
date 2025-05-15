return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    keys = {
      { "gt", "<cmd>BufferNext<cr>", desc = "Go to next tab" },
      { "gT", "<cmd>BufferPrevious<cr>", desc = "Go to previous tab" },
    },
    opts = {
    },
    version = '^1.0.0',
  },
}
