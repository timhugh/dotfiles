require("options")
require("bindings")
require("plugin").setup()
require("lsp").setup()

if vim.g.neovide then
  vim.o.guifont = "Lilex:h15"
  vim.o.linespace = 8

  vim.g.neovide_input_macos_option_key_is_meta = "both"

  vim.g.neovide_cursor_animation_length = 0.1
end
