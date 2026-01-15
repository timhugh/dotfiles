require('lsp').configure_lsp('gopls', {
  enabled = true,
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  workspace_required = true,
  root_markers = { 'go.mod' },
})
