local M = {}

local utils = require('lsp.utils')

local function get_workspace_files()
  vim.notify("Searching for project files...")
  local all_files = vim.fn.split(vim.fn.system('git ls-files'), "\n")
  local absolute_files = vim.tbl_map(function(path)
    return vim.fn.fnamemodify(path, ":p")
  end, all_files)
  -- git ls-files can return files that don't actually exist (e.g. if they were deleted but not committed)
  local existing_files = vim.tbl_filter(function(path)
    return vim.fn.filereadable(path) == 1
  end, absolute_files)
  return existing_files
end

local function lsp_supports_workspace_diagnostics(client)
  return vim.tbl_get(client.server_capabilities, 'textDocumentSync', 'openClose') and utils.is_supported_lsp(client)
end

local function process_batch(clients, files, start_index)
  local batch_size = 50
  local end_index = math.min(start_index + batch_size - 1, #files)

  for i = start_index, end_index do
    local path = files[i]
    local filetype = vim.filetype.match({ filename = path })

    for _, client in ipairs(clients) do
      if vim.tbl_contains(client.config.filetypes, filetype) then
        -- Don't re-diagnose buffers that are already open and attached to a client
        if vim.lsp.get_clients({ bufnr = vim.uri_to_bufnr(vim.uri_from_fname(path)) })[1] then
          goto continue_file
        end

        local params = {
          textDocument = {
            uri = vim.uri_from_fname(path),
            version = 0,
            text = table.concat(vim.fn.readfile(path), "\n"),
            languageId = filetype,
          },
        }
        client:notify('textDocument/didOpen', params)
        -- We only need one client to process a file, so we can break here.
        goto continue_file
      end
    end
    ::continue_file::
  end

  if end_index < #files then
    vim.notify(string.format("Processed %d/%d files...", end_index, #files))
    vim.defer_fn(function()
      process_batch(clients, files, end_index + 1)
    end, 100) -- 100ms delay to keep UI responsive
  else
    vim.notify("Workspace diagnostics complete. Processed " .. #files .. " files.")
  end
end

function M.run()
  vim.schedule(function()
    local files = get_workspace_files()
    if not files or #files == 0 then
      vim.notify("No files found for workspace diagnostics.", vim.log.levels.WARN)
      return
    end

    local active_clients = vim.lsp.get_active_clients()
    local supported_clients = {}
    for _, client in ipairs(active_clients) do
      if lsp_supports_workspace_diagnostics(client) then
        table.insert(supported_clients, client)
      end
    end

    if #supported_clients == 0 then
      vim.notify("No running LSP server supports workspace diagnostics.", vim.log.levels.WARN)
      return
    end

    vim.notify("Starting workspace diagnostics for " .. #files .. " files...")
    process_batch(supported_clients, files, 1)
  end)
end

return M
