require('lsp').configure_lsp('standardrb', {
  enabled = false,
  cmd = { 'standardrb', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
})
