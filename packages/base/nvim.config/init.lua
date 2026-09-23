require("options")
require("bindings")

require("dispatch")
require("autocomplete")
-- require("bujo")
require("lsp")

require("plugin").setup()
require("edit_cli")

if vim.g.neovide then
  vim.o.guifont = "Cascadia Code ExtraLight:h13"
  vim.o.linespace = 6
end
