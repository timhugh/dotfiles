if vim.g.vscode then
  require('vscode-keymaps')
else
  require("core.options")
  require("core.mappings")
  require("core.lazy").setup()
  require("lsp").setup()
end
