return {
  cmd = { 
    'clangd',
    '--background-index',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
  },
  settings = {
    clangd = {
      onConfigChanged = 'restart',
    },
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities({
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offSetEncoding = { 'utf-8', 'utf-16' },
  }),
  on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
}
