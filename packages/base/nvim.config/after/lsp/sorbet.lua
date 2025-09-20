return {
  cmd = { 'srb', 'tc', '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
