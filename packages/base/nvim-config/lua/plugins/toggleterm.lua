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

    vim.api.nvim_create_user_command("T", ":TermExec direction=horizontal size=20 cmd=<q-args><cr>", { nargs = 1 })
  end,
}
