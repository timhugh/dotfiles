local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local list_projects = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Projects",
    finder = finders.new_oneshot_job({
      "edit-cli", "projects", "list"
    }, opts),
    sorter = sorters.get_fuzzy_file(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("cd " .. selection[1] .. " | edit " .. selection[1])
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("Projects", function()
  list_projects()
end, { desc = "List Projects" })
