local utils = require('lsp.utils')

vim.api.nvim_create_user_command('LspLog', function()
  local log_path = vim.lsp.get_log_path()
  if log_path then
    vim.cmd('edit ' .. log_path)
  else
    vim.notify("LSP log path not found", vim.log.levels.ERROR)
  end
end, { desc = "Open LSP log" })

vim.api.nvim_create_user_command('LspInfo', function()
  vim.cmd('checkhealth vim.lsp')
end, { desc = "Show LSP health dashboard" })

vim.api.nvim_create_user_command('LspRestart', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if utils.is_supported_lsp(client) then
      vim.lsp.enable(client.name, false)
      vim.lsp.enable(client.name, true)
    end
  end
end, { desc = "Restart LSP servers" })

vim.api.nvim_create_user_command('LspWorkspaceDiagnostics', function()
  require('lsp.workspace_diagnostics').run()
end, { desc = 'Run workspace diagnostics for the entire project' })

