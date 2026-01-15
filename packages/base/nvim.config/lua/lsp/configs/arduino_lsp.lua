require('lsp').configure_lsp('arduino_language_server', {
  enabled = true,
  cmd = { 
    'arduino-language-server', 
    '-cli-config', vim.fn.expand('${HOME}/Library/Arduino15/arduino-cli.yaml'),
  },
  filetypes = { 'cpp' },
  workspace_required = true,
  root_markers = { 'platformio.ini' },
  settings = {},
})
