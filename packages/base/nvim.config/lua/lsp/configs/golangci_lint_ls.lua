require('lsp').configure_lsp('golangci_lint_ls', {
  enabled = true,
  cmd = { 'golangci-lint-langserver' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  init_options = {
    -- https://github.com/nametake/golangci-lint-langserver?tab=readme-ov-file#configuration-for-vim-lsp
    command = { 'golangci-lint', 'run', '--output.json.path', 'stdout', '--show-stats=false', '--issues-exit-code=1' },
  },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  workspace_required = true,
  root_markers = { 'go.mod', 'go.work' },
  before_init = function(_, config)
    -- Borrowing this logic (and the following comments) from nvim-lspconfig:
    -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/golangci_lint_ls.lua
    --
    -- Add support for golangci-lint V1 (in V2 `--out-format=json` was replaced by
    -- `--output.json.path=stdout`).
    local v1, v2 = false, false
    -- PERF: `golangci-lint version` is very slow (about 0.1 sec) so let's find
    -- version using `go version -m $(which golangci-lint) | grep '^\smod'`.
    if vim.fn.executable 'go' == 1 then
      local exe = vim.fn.exepath 'golangci-lint'
      local version = vim.system({ 'go', 'version', '-m', exe }):wait()
      v1 = string.match(version.stdout, '\tmod\tgithub.com/golangci/golangci%-lint\t')
      v2 = string.match(version.stdout, '\tmod\tgithub.com/golangci/golangci%-lint/v2\t')
    end
    if not v1 and not v2 then
      local version = vim.system({ 'golangci-lint', 'version' }):wait()
      v1 = string.match(version.stdout, 'version v?1%.')
    end
    if v1 then
      config.init_options.command = { 'golangci-lint', 'run', '--out-format', 'json' }
    end
  end,
})
