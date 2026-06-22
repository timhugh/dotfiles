require('lsp').configure_lsp('glsl_analyzer', {
  enabled = true,
  cmd = { 'glsl_analyzer' },
  filetypes = { 'glsl' },
  root_markers = { '.git' },
  capabilities = {},
})
