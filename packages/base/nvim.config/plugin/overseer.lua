require('lazyload').on_vim_enter(function()
  vim.pack.add({
    'https://github.com/stevearc/overseer.nvim',
  })

  require('overseer').setup()

  local last_cmd = nil

  local run_cmd = function(cmd)
    if cmd then
      vim.cmd('OverseerShell ' .. cmd)
    else
      vim.notify("No command provided...", vim.log.levels.WARN)
    end
  end

  local prompt_cmd = function()
    last_cmd = vim.fn.input('>')
    return last_cmd
  end

  local run_new_cmd = function()
    run_cmd(prompt_cmd())
  end

  local rerun_cmd = function()
    if last_cmd and last_cmd ~= "" then
      run_cmd(last_cmd)
    else
      run_new_cmd()
    end
  end

  vim.keymap.set('n', '<leader>r', rerun_cmd, { desc = 'overseer: rerun last command' })
  vim.keymap.set('n', '<leader>R', run_new_cmd, { desc = 'overseer: run new command' })
  vim.keymap.set('n', '<leader>o', '<cmd>OverseerOpen<cr>', { desc = 'overseer: open UI' })
  vim.keymap.set('n', '<leader>O', '<cmd>OverseerToggle<cr>', { desc = 'overseer: toggle UI' })
end)
