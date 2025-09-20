return {
  cmd = { 'golangci-lint-langserver' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  init_options = {
    -- https://github.com/nametake/golangci-lint-langserver?tab=readme-ov-file#configuration-for-vim-lsp
    command = { 'golangci-lint', 'run', '--output.json.path', 'stdout', '--show-stats=false', '--issues-exit-code=1' },
  },
  root_markers = {
    'go.mod',
    '.git',
  },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
