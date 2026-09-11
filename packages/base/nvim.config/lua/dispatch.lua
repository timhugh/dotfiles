local native_adapter = {
  kill_existing_cmd = function(_)
    -- no-op for native adapter
  end,
  run_cmd = function(self, target, cmd)
    vim.cmd(self.target_mapping[target] .. " | terminal " .. cmd)
  end,
  target_mapping = {
    ["tab"] = "tabnew",
    ["vsplit"] = "vsplit",
    ["hsplit"] = "split",
  },
}

local tmux_adapter = {
  last_pane = nil,
  kill_existing_cmd = function(self)
    if self.last_pane then
      vim.fn.system({ "tmux", "kill-pane", "-t", self.last_pane })
      self.last_pane = nil
    end
  end,
  run_cmd = function(self, target, cmd)
    self:kill_existing_cmd()

    local current_pane = nil
    local output = vim.fn.system({ "tmux", "display-message", "-p", "#{pane_id}" })
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to get current tmux pane: " .. output, vim.log.level.ERROR)
    else
      current_pane = vim.trim(output)
    end

    local args = { "tmux" }
    vim.list_extend(args, self.target_mapping[target])
    vim.list_extend(args, {
      "-P", "-F", "#{pane_id}", cmd .. " || read"
    })
    output = vim.fn.system(args)
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to create tmux runner: " .. output, vim.log.levels.ERROR)
    else
      self.last_pane = vim.trim(output)
    end

    output = vim.fn.system({ "tmux", "select-pane", "-t", current_pane })
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to select current tmux pane: " .. output, vim.log.level.ERROR)
    end
  end,
  target_mapping = {
    ["tab"] = { "new-window" },
    ["vsplit"] = { "split-window", "-h" },
    ["hsplit"] = { "split-window", "-v" },
  },
}

local cmux_adapter = {
  last_surface = nil,
  kill_existing_cmd = function(self)
    if self.last_surface then
      vim.fn.system({ "cmux", "close-surface", "--surface", self.last_surface })
      self.last_surface = nil
    end
  end,
  run_cmd = function(self, target, cmd)
    self:kill_existing_cmd()

    local open_args = { "cmux" }
    vim.list_extend(open_args, self.target_mapping[target])
    local output = vim.fn.system(open_args)
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to create new cmux pane: " .. output, vim.log.level.ERROR)
      return
    end

    self.last_surface = string.match(output, "surface:%d+")
    output = vim.fn.system({ "cmux", "send", "--surface", self.last_surface, cmd, "&& exit || read && exit", "\n" })
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to send comand to cmux pane: " .. output, vim.log.level.ERROR)
      return
    end
  end,
  target_mapping = {
    ["tab"] = { "new-surface" },
    ["vsplit"] = { "new-pane", "--direction", "right" },
    ["hsplit"] = { "new-pane", "--direction", "down" },
  },
}

-- set adapter for current session
local current_adapter = nil
if vim.env.TMUX ~= nil then
  current_adapter = tmux_adapter
elseif vim.env.CMUX_WORKSPACE_ID ~= nil then
  current_adapter = cmux_adapter
else
  current_adapter = native_adapter
end

local run_cmd = function(target, cmd)
  if not cmd then
    vim.notify("No command provided...", vim.log.levels.WARN)
    return
  end
  current_adapter:run_cmd(target, cmd)
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

vim.keymap.set("n", "<leader>R", function() prompt_cmd("tab") end, { desc = "dispatch: new command in new tab" })
vim.keymap.set("n", "<leader>r", function() reuse_cmd("tab") end, { desc = "dispatch: repeat command in new tab" })
vim.keymap.set("n", "<leader>H", function() prompt_cmd("hsplit") end,
  { desc = "dispatch: new command in horizontal split" })
vim.keymap.set("n", "<leader>h", function() reuse_cmd("hsplit") end,
  { desc = "dispatch: repeat command in horizontal split" })
vim.keymap.set("n", "<leader>V", function() prompt_cmd("vsplit") end,
  { desc = "dispatch: new command in vertical split" })
vim.keymap.set("n", "<leader>v", function() reuse_cmd("vsplit") end,
  { desc = "dispatch: repeat command in vertical split" })
vim.keymap.set("n", "<leader>K", function() current_adapter:kill_existing_cmd() end,
  { desc = "dispatch: kill existing command" })

vim.keymap.set("n", "<leader>ol", function() run_cmd("tab", "lazygit") end, { desc = "dispatch: lazygit" })
vim.keymap.set("n", "<leader>oc", function() run_cmd("tab", "opencode") end, { desc = "dispatch: opencode" })
vim.keymap.set("n", "<leader>op", function() run_cmd("tab", "pi") end, { desc = "dispatch: pi" })
