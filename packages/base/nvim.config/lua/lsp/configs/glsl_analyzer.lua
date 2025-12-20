require('lsp').configure_lsp('glsl_analyzer', {
  enabled = true,
  cmd = { 'glsl_analyzer' },
  filetypes = { 'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp' },
  root_markers = { '.git' },
  capabilities = {},
})
