require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/nvim-mini/mini.nvim',
  })

  require('mini.notify').setup()
  require('mini.input').setup()
  require('mini.completion').setup()
  require('mini.surround').setup()
  require('mini.pick').setup()
  require('mini.extra').setup()

  -- standard pickers
  vim.keymap.set('n', '<leader>ff', require('mini.extra').pickers.git_files, { desc = 'mini.pick: git tracked files' })
  vim.keymap.set('n', '<leader>fF', require('mini.pick').builtin.files, { desc = 'mini.pick: files' })
  vim.keymap.set('n', '<leader>fG', require('mini.pick').builtin.grep_live, { desc = 'mini.pick: grep' })
  vim.keymap.set('n', '<leader>fgs', function()
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
          preview = function(buf_id, filepath)
            local file = io.open(filepath, "r")
            if not file then
              vim.notify("Failed to read file " .. filepath, vim.log.levels.WARN)
              return
            end
            local content = file:read('*a')
            file:close()
            local lines = vim.split(content, '\n')
            vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
          end,
          choose = function(filepath)
            if not filepath then
              vim.notify('No file selected', vim.log.levels.INFO)
            else
              vim.api.nvim_win_call(
                require('mini.pick').get_picker_state().windows.target,
                function() vim.cmd('edit ' .. filepath) end
              )
            end
          end,
        },
      })
    end,
    { desc = 'mini.pick: git status' }
  )

  -- extra git pickers
  vim.keymap.set('n', '<leader>fgm', function() require('mini.extra').pickers.git_files({ scope = 'modified' }) end,
    { desc = 'mini.pick: git modified files' })
  vim.keymap.set('n', '<leader>fgu', function() require('mini.extra').pickers.git_files({ scope = 'untracked' }) end,
    { desc = 'mini.pick: git untracked files' })
  vim.keymap.set('n', '<leader>fgh', require('mini.extra').pickers.git_hunks, { desc = 'mini.pick: git hunks' })

  -- project picker
  vim.keymap.set('n', '<leader>fp',
    function()
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
    { desc = 'mini.pick: projects' }
  )

  -- misc pickers
  vim.keymap.set('n', '<leader>fr', require('mini.pick').builtin.resume, { desc = 'mini.pick: resume' })
  vim.keymap.set('n', '<leader>ft', require('mini.extra').pickers.colorschemes, { desc = 'mini.pick: colorschemes' })
end)
