require('lsp').configure_lsp('rubocop', {
  enabled = false,
  cmd = { 'rubocop', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { '.rubocop.yml', 'Gemfile' },
})
