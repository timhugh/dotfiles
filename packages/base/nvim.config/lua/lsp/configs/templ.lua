require('lsp').configure_lsp('templ', {
  cmd = { 'templ', 'lsp' },
  filetypes = { 'templ' },
  root_markers = {
    'go.mod',
    '.git',
  },
})
