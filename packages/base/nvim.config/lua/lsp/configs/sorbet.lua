require('lsp').configure_lsp('sorbet', {
  enabled = false,
  cmd = { 'srb', 'tc', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
})
