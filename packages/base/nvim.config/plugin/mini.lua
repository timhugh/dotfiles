require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/nvim-mini/mini.nvim',
  })

  require('mini.notify').setup()
  require('mini.input').setup()
  require('mini.completion').setup()
  require('mini.surround').setup()
  require('mini.pick').setup({
    mappings = {
      choose_in_split = '<c-->',
      choose_in_vsplit = '<c-\\>',
    },
  })
  require('mini.extra').setup()

  local pick_commands = {
    {
      desc = 'mini.pick: resume',
      exec = require('mini.pick').builtin.resume,
      aliases = { 'PickResume', 'Pr' },
      binds = { '<leader>fr' },
    },
    {
      desc = 'mini.pick: files',
      exec = require('mini.pick').builtin.files,
      binds = { '<leader>fF' },
    },
    {
      desc = 'mini.pick: git tracked files',
      exec = require('mini.extra').pickers.git_files,
      aliases = { 'Pf' },
      binds = { '<leader>ff' },
    },
    {
      desc = 'mini.pick: grep',
      exec = require('mini.pick').builtin.grep_live,
      aliases = { 'PG' },
      binds = { '<leader>fG' },
    },
    {
      desc = 'mini.pick: git status',
      exec = function()
        local git_output = vim.fn.system('git status --porcelain')
        if vim.v.shell_error ~= 0 then
          vim.notify('Failed to get git status: ' .. git_output, vim.log.levels.ERROR)
          return
        end
        local git_lines = vim.split(git_output, '\n', { trimempty = true })
        local git_files = {}
        for i, item in ipairs(git_lines) do
          local parts = vim.split(item, ' ')
          git_files[i] = parts[3]
        end
        require('mini.pick').start({
          source = {
            name = 'Git modified files',
            items = git_files,
          },
        })
      end,
      aliases = { 'PickGitStatus', 'Pgs' },
      binds = { '<leader>fgs' },
    },
    {
      desc = 'mini.pick: git modified files',
      exec = function() require('mini.extra').pickers.git_files({ scope = 'modified' }) end,
      aliases = { 'PickGitModifiedFiles', 'Pgm' },
      binds = { '<leader>fgm' },
    },
    {
      desc = 'mini.pick: git untracked files',
      exec = function() require('mini.extra').pickers.git_files({ scope = 'untracked' }) end,
      aliases = { 'PickGitUntrackedFiles', 'Pgu' },
      binds = { '<leader>fgu' },
    },
    {
      desc = 'mini.pick: git hunks',
      exec = require('mini.extra').pickers.git_hunks,
      aliases = { 'PickGitHunks', 'Pgh' },
      binds = { '<leader>fgh' },
    },
    {
      desc = 'mini.pick: projects',
      exec = function()
        local projects_output = vim.fn.system('edit-cli projects list')
        if vim.v.shell_error ~= 0 then
          vim.notify('Failed to get project list: ' .. projects_output, vim.log.levels.INFO)
          return
        end
        local project_paths = vim.split(projects_output, '\n', { trimempty = true })
        require('mini.pick').start({
          source = {
            name = 'Projects',
            items = project_paths,
            preview = function(buf_id, project_path)
              local preview_lines = {}
              local ls_output = vim.fn.system('ls ' .. project_path)
              if vim.v.shell_error ~= 0 then
                vim.notify('Failed to list files in directory ' .. project_path, vim.log.levels.WARN)
              end
              preview_lines = vim.split(ls_output, '\n')
              vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, preview_lines)
            end,
            choose = function(project_path)
              if not project_path then
                vim.notify('No project selected', vim.log.levels.INFO)
              else
                vim.api.nvim_win_call(
                  require('mini.pick').get_picker_state().windows.target,
                  function() vim.cmd('cd ' .. project_path .. ' | edit .') end
                )
              end
            end,
          },
        })
      end,
      aliases = { 'PickProjects', 'Ppr' },
      binds = { '<leader>fp' },
    },
    {
      desc = 'mini.pick: lsp document symbols',
      exec = function() require('mini.extra').pickers.lsp({ scope = 'document_symbol' }) end,
      aliases = { 'PickLspDocumentSymbols', 'Pls' },
      binds = { '<leader>fls' },
    },
    {
      desc = 'mini.pick: lsp workspace symbols',
      exec = function() require('mini.extra').pickers.lsp({ scope = 'workspace_symbol' }) end,
      aliases = { 'PickLspWorkspaceSymbols', 'PlS' },
      binds = { '<leader>flS' },
    },
    {
      desc = 'mini.pick: lsp references',
      exec = function() require('mini.extra').pickers.lsp({ scope = 'references' }) end,
      aliases = { 'PickLspReferences', 'Plr' },
      binds = { '<leader>flr' },
    },
    {
      desc = 'mini.pick: colorschemes',
      exec = require('mini.extra').pickers.colorschemes,
      aliases = { 'PickThemes' },
      binds = { '<leader>ft' },
    },
  }

  for _, command in ipairs(pick_commands) do
    for _, alias in ipairs(command.aliases or {}) do
      vim.api.nvim_create_user_command(alias, command.exec, { desc = command.desc })
    end
    for _, bind in ipairs(command.binds or {}) do
      vim.keymap.set('n', bind, command.exec, { desc = command.desc })
    end
  end
end)
