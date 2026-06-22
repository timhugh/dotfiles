require('lsp').configure_lsp('zls', {
  enabled = true,
  cmd = { 'zls' },
  filetypes = { 'zig' },
  root_markers = { '.git' },
  settings = {},
})
