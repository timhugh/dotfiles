require('lsp').configure_lsp('templ', {
  enabled = true,
  cmd = { 'templ', 'lsp' },
  filetypes = { 'templ' },
  workspace_required = true,
  root_markers = { 'go.mod' },
})
