require('lsp').configure_lsp('bashls', {
  enabled = true,
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash', 'zsh' },
  root_markers = { '.git' },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or '**/*.{sh,bash,zsh}',
    },
  },
})
