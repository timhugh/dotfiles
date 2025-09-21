require('lsp').configure_lsp('rubocop', {
  cmd = { 'rubocop', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { '.rubocop.yml', 'Gemfile', '.git' },
})
