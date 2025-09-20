return {
  cmd = { 'nginx-language-server' },
  filetypes = { 'nginx' },
  root_markers = { 'nginx.conf', '.git' },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
