require('lazyload').on_vim_enter(function()
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      if ev.data.spec.name == 'nvim-treesitter' then
        vim.cmd('TSUpdate')
      end
    end,
  })

  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
  })

  local ensure_installed = {
    'bash',
    'make',
    'jq',
    'ssh_config',

    'ledger',

    'cmake',
    'c',
    'cpp',
    'glsl',
    'llvm',

    'css',
    'dockerfile',

    'gdscript',
    'gdshader',
    'godot_resource',

    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',

    'go',
    'gomod',
    'gosum',
    'gotmpl',
    'gowork',
    'templ',

    'helm',
    'http',

    'java',
    'kotlin',

    'astro',
    'graphql',
    'javascript',
    'tsv',
    'tsx',
    'typescript',
    'vue',

    'json',
    'toml',
    'yaml',

    'html',
    'markdown',
    'markdown_inline',
    'regex',
    'scss',
    'sql',
    'xml',

    'ruby',

    'python',

    'lua',
    'vim',

    'perl',

    'rust',
  }

  require('nvim-treesitter').install(ensure_installed)

  vim.api.nvim_create_autocmd('FileType', {
    desc = 'User: enable treesitter',
    callback = function(ctx)
      local hasStarted = pcall(vim.treesitter.start)

      local noIndent = {}
      if hasStarted and not vim.list_contains(noIndent, ctx.match) then
        vim.opt.foldmethod = 'expr'
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.opt.foldtext = ''
      end
    end,
  })
end)
