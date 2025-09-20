return {
  cmd = { 'glsl_analyzer' },
  filetypes = { 'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp' },
  root_markers = { '.git' },
  capabilities = {},
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
