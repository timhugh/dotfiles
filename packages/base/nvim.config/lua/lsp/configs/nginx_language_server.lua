require('lsp').setup('nginx_language_server', {
  cmd = { 'nginx-language-server' },
  filetypes = { 'nginx' },
  root_markers = { 'nginx.conf', '.git' },
})
