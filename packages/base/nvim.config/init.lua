if vim.g.vscode then
  require('vscode-keymaps')
else
  require("core.options")
  require("core.mappings")
  require("lsp")
  require("core.lazy").setup()
end
