return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>T", "<cmd>ToggleTerm direction=horizontal size=20<cr>", desc = "Open toggleterm" },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      start_in_insert = true,
    })

    vim.api.nvim_create_user_command("X", ":TermExec direction=horizontal size=20 cmd=<q-args><cr>", { nargs = 1 })

    vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
  end,
}
