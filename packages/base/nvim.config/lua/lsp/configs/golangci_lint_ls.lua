require('lsp').setup('golangci_lint_ls', {
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
})
