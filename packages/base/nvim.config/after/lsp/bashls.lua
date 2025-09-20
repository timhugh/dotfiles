return {
  cmd= { 'bash-language-server', 'start' },
  filetypes= { 'sh', 'bash', 'zsh' },
  root_markers= { '.git' },
  settings= {
    bashIde= {
      globPattern=vim.env.GLOB_PATTERN or '**/*.{sh,bash,zsh}',
    },
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
