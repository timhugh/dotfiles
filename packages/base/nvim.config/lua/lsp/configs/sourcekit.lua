require('lsp').configure_lsp('sourcekit', {
  enabled = true,
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift', 'objc', 'objcpp' },
  root_markers = { '*.xcodeproj', '.git' },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
        relatedDocumentSupport = true,
      },
    },
  },
})
