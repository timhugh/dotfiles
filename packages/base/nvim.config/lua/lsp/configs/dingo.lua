require('lsp').configure_lsp('dingo', {
  enabled = true,
  cmd = { 'dingo-lsp' },
  filetypes = { 'dingo' },
  root_markers = { 'go.mod', '.git' },
  settings = {},
})
