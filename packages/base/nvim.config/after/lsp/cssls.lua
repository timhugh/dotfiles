return {
  cmd= { 'vscode-css-language-server', '--stdio' },
  filetypes= { 'css', 'scss', 'less' },
  root_markers= { 'package.json', '.git' },
  init_options= {
    provideFormatter=true,
  },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
  settings= {
    css= { validate=true },
    scss= { validate=true },
    less= { validate=true },
  },
}
