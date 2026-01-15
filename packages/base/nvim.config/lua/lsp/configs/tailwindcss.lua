require('lsp').configure_lsp('tailwindcss', {
  enabled = true,
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'html',
    'css',
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact'
  },
  workspace_required = true,
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
      includeLanguages = {
        eruby = 'erb',
        templ = 'html',
      },
    },
  },
  before_init = function(_, config)
    if not config.settings then
      config.settings = {}
    end
    if not config.settings.editor then
      config.settings.editor = {}
    end
    if not config.settings.editor.tabSize then
      config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  workspace_required = true,
  on_attach = function(client, bufnr)
    -- tailwind always runs in tandem with either cssls or one of the JS lsps which already provide formatting
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
