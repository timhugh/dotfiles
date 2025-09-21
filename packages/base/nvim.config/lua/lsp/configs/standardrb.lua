require('lsp').setup('standardrb', {
  cmd = { 'standardrb', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
})
