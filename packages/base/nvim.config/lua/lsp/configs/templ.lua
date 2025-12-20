require('lsp').configure_lsp('templ', {
  enabled = true,
  cmd = { 'templ', 'lsp' },
  filetypes = { 'templ' },
  root_markers = {
    'go.mod',
    '.git',
  },
})
