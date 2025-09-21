-- some LSPs (like copilot) are not actually LSPs and need to be handled differently at times
local unsupported_lsps = {
  copilot = true,
}

local function is_unsupported_lsp(client)
  return unsupported_lsps[client.name] or false
end

local function is_supported_lsp(client)
  return not is_unsupported_lsp(client)
end

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
    if is_supported_lsp(client) then
      vim.lsp.enable(client.name, false)
      vim.lsp.enable(client.name, true)
    end
  end
end, { desc = "Restart LSP servers" })

