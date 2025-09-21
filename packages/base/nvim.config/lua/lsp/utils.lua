local M = {}

-- some LSPs (like copilot) are not actually LSPs and need to be handled differently at times
local unsupported_lsps = {
  copilot = true,
}

function M.is_unsupported_lsp(client)
  return unsupported_lsps[client.name] or false
end

function M.is_supported_lsp(client)
  return not M.is_unsupported_lsp(client)
end

return M
