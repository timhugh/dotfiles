return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader><m-t>", "<cmd>ToggleTerm<cr>", desc = "Open toggleterm" },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      start_in_insert = true,
    })
  end,
}
