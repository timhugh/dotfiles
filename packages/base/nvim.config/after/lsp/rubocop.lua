return {
  cmd = { 'rubocop', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { '.rubocop.yml', 'Gemfile', '.git' },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
