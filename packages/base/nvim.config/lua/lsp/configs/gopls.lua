require('lsp').configure_lsp('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = {
    'go.mod',
    '.git',
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.code_action({
          context = { only = { 'source.organizeImports' } },
          apply = true,
        })
      end,
    })
  end,
})
