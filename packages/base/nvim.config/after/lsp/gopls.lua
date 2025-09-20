return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = {
    'go.mod',
    '.git',
  },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
