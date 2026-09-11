vim.keymap.set("n", "grf", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP Format Document" })

vim.keymap.set("n", "g.", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })

vim.keymap.set("n", "grh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle LSP Inlay Hints" })

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, { desc = "Show LSP Info" })

vim.api.nvim_create_user_command("LspLog", function()
  local log_path = vim.lsp.log.get_filename()
  vim.cmd("tabnew | edit " .. log_path)
end, { desc = "Show LSP Log" })

vim.api.nvim_create_user_command("LspLogClear", function()
  local log_path = vim.lsp.log.get_filename()
  local log_file = io.open(log_path, "w")
  if log_file then
    log_file:close()
    vim.notify("LSP log file cleared: " .. log_path, vim.log.levels.INFO)
  else
    vim.notify("Failed to clear LSP log file: " .. log_path, vim.log.levels.ERROR)
  end
end, { desc = "Clear log file" })

-- clear LSP logs on startup
vim.cmd("LspLogClear")
