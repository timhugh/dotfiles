local is_tmux = vim.env.TMUX ~= nil

local last_tmux_pane = nil
local kill_tmux_pane = function()
  if last_tmux_pane then
    vim.fn.system({ "tmux", "kill-pane", "-t", last_tmux_pane })
    last_tmux_pane = nil
  end
end
local tmux_cmd_wrapper = function(target)
  return function(cmd)
    kill_tmux_pane()

    local current_pane = nil
    local output = vim.fn.system({ "tmux", "display-message", "-p", "#{pane_id}" })
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to get current tmux pane: " .. output, vim.log.level.ERROR)
    else
      current_pane = vim.trim(output)
    end

    local args = { "tmux" }
    vim.list_extend(args, target)
    vim.list_extend(args, {
      "-P", "-F", "#{pane_id}", cmd .. " || read"
    })
    output = vim.fn.system(args)
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to create tmux runner: " .. output, vim.log.levels.ERROR)
    else
      last_tmux_pane = vim.trim(output)
    end

    output = vim.fn.system({ "tmux", "select-pane", "-t", current_pane })
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to select current tmux pane: " .. output, vim.log.level.ERROR)
    end
  end
end
local terminal_cmd_wrapper = function(target)
  return function(cmd)
    vim.cmd(target .. " | terminal " .. cmd)
  end
end
local run_targets = {
  ["tab"] = is_tmux and tmux_cmd_wrapper({ "new-window" }) or terminal_cmd_wrapper("tabnew"),
  ["vsplit"] = is_tmux and tmux_cmd_wrapper({ "split-window", "-h" }) or terminal_cmd_wrapper("vsplit"),
  ["hsplit"] = is_tmux and tmux_cmd_wrapper({ "split-window", "-v" }) or terminal_cmd_wrapper("split"),
}
local run_cmd = function(target, cmd)
  if not cmd then
    vim.notify("No command provided...", vim.log.levels.WARN)
    return
  end
  local wrapper = run_targets[target]
  if not wrapper then
    vim.notify("Invalid run target: " .. target, vim.log.levels.ERROR)
    return
  end
  wrapper(cmd)
end
local prompt_cmd = function(target, prompt)
  vim.ui.input({
    prompt = prompt or "> ",
  }, function(cmd)
    vim.g.last_run_cmd = cmd
    run_cmd(target, cmd)
  end)
end
local reuse_cmd = function(target)
  if vim.g.last_run_cmd then
    run_cmd(target, vim.g.last_run_cmd)
  else
    prompt_cmd(target, "?>")
  end
end
vim.keymap.set("n", "<leader>R", function() prompt_cmd("tab") end, { desc = "run new command in new tab" })
vim.keymap.set("n", "<leader>r", function() reuse_cmd("tab") end, { desc = "re-run last command in new tab" })
vim.keymap.set("n", "<leader>H", function() prompt_cmd("hsplit") end, { desc = "run new command in horizontal split" })
vim.keymap.set("n", "<leader>h", function() reuse_cmd("hsplit") end, { desc = "re-run last command in horizontal split" })
vim.keymap.set("n", "<leader>V", function() prompt_cmd("vsplit") end, { desc = "run new command in vertical split" })
vim.keymap.set("n", "<leader>v", function() reuse_cmd("vsplit") end, { desc = "re-run last command in vertical split" })
vim.keymap.set("n", "<leader>K", function() kill_tmux_pane() end, { desc = "kill last tmux pane" })

if is_tmux then
  vim.keymap.set("n", "<leader>og", "<cmd>:silent !tmux new-window lazygit<cr>",
    { desc = "lazygit: Open in tmux window" })
else
  vim.keymap.set("n", "<leader>og", "<cmd>:silent terminal lazygit<cr>", { desc = "lazygit: Open in terminal" })
end
if is_tmux then
  vim.keymap.set("n", "<leader>oc", "<cmd>:silent !tmux split-window -h opencode<cr>",
    { desc = "opencode: Open in tmux split" })
else
  vim.keymap.set("n", "<leader>oc", "<cmd>:silent vsplit | terminal opencode<cr>",
    { desc = "opencode: Open in terminal split" })
end

