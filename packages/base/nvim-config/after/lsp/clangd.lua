vim.lsp.config('clangd', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  cmd = { 'clangd' },
  filetypes = { 'cpp' },
  root_markers = { '.clangd', 'compile_commands.json' },
  settings = {
    clangd = {
      onConfigChanged = 'restart',
    },
  },
})
