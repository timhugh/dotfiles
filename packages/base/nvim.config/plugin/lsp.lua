require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/RubixDev/mason-update-all',
  })

  require('mason').setup()

  vim.keymap.set('n', '<leader>M', '<cmd>Mason<cr>', { desc = 'mason' })

  -- astro_ls and typescript 7 don't get along
  local typescript_root = vim.fn.system({ 'mise', 'where', 'npm:typescript@6.0.3' }):gsub('%s+$', '')
  vim.lsp.config('astro', {
    cmd = { 'mise', 'x', 'npm:@astrojs/language-server@2.16.13', '--', 'astro-ls', '--stdio' },
    before_init = function(_, config)
      config.init_options.typescript.tsdk = typescript_root .. '/node_modules/typescript/lib'
    end,
  })
  vim.lsp.enable('astro')

  require('mason-lspconfig').setup({
    automatic_enable = {
      exclude = { 'astro' },
    },
    ensure_installed = {
      'bashls',
      'clangd',
      'cmake',
      'cssls',
      'glsl_analyzer',
      'golangci_lint_ls',
      'gopls',
      'html',
      'jdtls',
      'jsonls',
      -- managing kotlin_lsp externally:
      -- 'kotlin_lsp',
      'lua_ls',
      'markdown_oxide',
      'pylsp',
      -- 'rubocop',
      'ruby_lsp',
      'rust_analyzer',
      -- 'sorbet',
      -- 'standardrb',
      'tailwindcss',
      'taplo',
      'templ',
      'ts_ls',
      'yamlls',
      'zls',
    },
  })

  -- godot lsp config
  local port = os.getenv 'GDScript_Port' or '6005'
  local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))

  local server_pipe_path = vim.fn.getcwd() .. '/server.pipe'

  vim.lsp.config('gdscript', {
    enabled = true,
    cmd = cmd,
    filetypes = { 'gdscript' },
    workspace_required = true,
    root_markers = { 'project.godot' },
    on_attach = function()
      local is_server_running = vim.uv.fs_stat(server_pipe_path)
      if not is_server_running then
        vim.fn.serverstart(server_pipe_path)
      end
    end,
  })
  vim.lsp.enable('gdscript');

  -- kotlin lsp config
  vim.lsp.config('kotlin_lsp', {
    cmd = { 'kotlin-lsp', '--stdio' },
    filetypes = { 'kotlin' },
    root_markers = { 'settings.gradle', 'settings.gradle.kts', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'workspace.json' },
  })
  vim.lsp.enable('kotlin_lsp')

  require('mason-update-all').setup()
end)
