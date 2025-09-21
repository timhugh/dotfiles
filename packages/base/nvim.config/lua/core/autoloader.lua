local M = {}

function M.load(module_path)
  local dir = vim.fn.stdpath("config") .. "/lua/" .. module_path
  local files = vim.fn.readdir(dir)

  for _, file in ipairs(files) do
    if file:match("%.lua$") then
      local module_name = file:gsub("%.lua$", "")
      local full_module_path = module_path .. "." .. module_name
      pcall(require, full_module_path)
    end
  end
end

return M
