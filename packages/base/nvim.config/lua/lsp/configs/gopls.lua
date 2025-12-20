require('lsp').configure_lsp('gopls', {
  enabled = true,
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = {
    'go.mod',
    '.git',
  },
})
