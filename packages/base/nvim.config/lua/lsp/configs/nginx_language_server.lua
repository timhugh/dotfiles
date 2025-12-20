require('lsp').configure_lsp('nginx_language_server', {
  enabled = true,
  cmd = { 'nginx-language-server' },
  filetypes = { 'nginx' },
  root_markers = { 'nginx.conf', '.git' },
})
