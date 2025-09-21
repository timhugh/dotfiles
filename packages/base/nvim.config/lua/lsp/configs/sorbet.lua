require('lsp').configure_lsp('sorbet', {
  cmd = { 'srb', 'tc', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
})
