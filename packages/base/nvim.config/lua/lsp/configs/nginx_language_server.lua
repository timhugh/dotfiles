require('lsp').configure_lsp('nginx_language_server', {
  cmd = { 'nginx-language-server' },
  filetypes = { 'nginx' },
  root_markers = { 'nginx.conf', '.git' },
})
