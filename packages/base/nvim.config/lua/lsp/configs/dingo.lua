require('lsp').configure_lsp('dingo', {
  enabled = false,
  cmd = { 'dingo-lsp' },
  filetypes = { 'dingo' },
  root_markers = { 'go.mod', '.git' },
  settings = {},
})
