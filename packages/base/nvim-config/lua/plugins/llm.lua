return {
  {
    "ggml-org/llama.vim",
    init = function()
      vim.api.nvim_set_hl(0, "llama_hl_hint", {fg = "#999999", ctermfg="lightgray"})
      vim.api.nvim_set_hl(0, "llama_hl_info", {fg = "#444444", ctermfg="darkgray"})

      vim.g.llama_config = {
        show_info = false,
        keymap_accept_full = "<S-M-Tab>",
        keymap_accept_line = "<S-Tab>"
      }
    end,
  },
}
