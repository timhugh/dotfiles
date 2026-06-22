require('lsp').configure_lsp('yamlls', {
  enabled = true,
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = { '.git' },
  settings = {
    redhat = { telemetry = { enabled = false } },
  },
})
