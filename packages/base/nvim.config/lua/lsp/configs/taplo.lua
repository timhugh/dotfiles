require('lsp').configure_lsp('taplo', {
  enabled = true,
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = { '.git' },
})
