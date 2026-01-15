require('lsp').configure_lsp('cmake', {
  enabled = true,
  cmd = { 'cmake-language-server' },
  filetypes = { 'cmake' },
  workspace_required = true,
  root_markers = { 'CMakeLists.txt' },
})
