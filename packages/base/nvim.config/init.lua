if vim.g.vscode then
  require('vscode-keymaps')
else
  require("core.options")
  require("core.mappings")
  require("lsp")
  require("core.autoloader")
  require("core.lazy").setup()
end
