local port = os.getenv 'GDScript_Port' or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))

local server_pipe_path = vim.fn.getcwd() .. '/server.pipe'
local is_server_running = vim.uv.fs_stat(server_pipe_path)
if not is_server_running then
    vim.fn.serverstart(server_pipe_path)
end

return {
  cmd = cmd,
  filetypes = { 'gd', 'gdscript', 'gdscript3' },
  root_markers = { 'project.godot', '.git' },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
