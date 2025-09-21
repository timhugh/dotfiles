require('lsp').setup('rubocop', {
  cmd = { 'rubocop', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { '.rubocop.yml', 'Gemfile', '.git' },
})
