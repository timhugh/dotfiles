return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>T", "<cmd>ToggleTerm<cr>", desc = "Open toggleterm" },
    { "<leader>TT", "<cmd>2ToggleTerm<cr>", desc = "Open second toggleterm" },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "horizontal",
      start_in_insert = true,
      size = 20,
    })

    vim.api.nvim_create_user_command("X", ":TermExec direction=horizontal size=20 cmd=<q-args><cr>", { nargs = 1 })

    vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
  end,
}
