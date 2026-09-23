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

  -- extra git pickers
  vim.keymap.set('n', '<leader>fgm', function() require('mini.extra').pickers.git_files({ scope = 'modified' }) end,
    { desc = 'mini.pick: git modified files' })
  vim.keymap.set('n', '<leader>fgu', function() require('mini.extra').pickers.git_files({ scope = 'untracked' }) end,
    { desc = 'mini.pick: git untracked files' })
  vim.keymap.set('n', '<leader>fgh', require('mini.extra').pickers.git_hunks, { desc = 'mini.pick: git hunks' })

  -- project picker
  -- TODO: needs to also CD into the directory
  vim.keymap.set('n', '<leader>fp',
    function()
      -- require('mini.pick').builtin.cli({ command = { 'edit-cli', 'projects', 'list' } })
      local output = vim.fn.system("edit-cli projects list")
      if vim.v.shell_error ~= 0 then
        vim.notify("Failed to get project list: " .. output, vim.logs.level.ERROR)
        return
      end
      local items = vim.split(output, "\n", { trimempty = true })
      vim.ui.select(items, {},
        function(project_dir)
          vim.cmd("cd " .. project_dir .. " | edit .")
        end
      )
    end,
    { desc = 'mini.pick: projects' }
  )

  -- misc pickers
  vim.keymap.set('n', '<leader>fr', require('mini.pick').builtin.resume, { desc = 'mini.pick: resume' })
  vim.keymap.set('n', '<leader>ft', require('mini.extra').pickers.colorschemes, { desc = 'mini.pick: colorschemes' })
end)
