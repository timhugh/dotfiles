require("options")
require("bindings")
require("plugin").setup()

-- clear LSP logs on startup
vim.cmd("LspLogClear")
