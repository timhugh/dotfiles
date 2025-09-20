return {
  cmd = { 'cmake-language-server' },
  filetypes = { 'cmake' },
  root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
  -- init_options = {
  --   buildDirectory = 'build',
  -- },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
