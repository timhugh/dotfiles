vim.g.mapleader = ","

local is_tmux = vim.env.TMUX ~= nil

vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>")

-- split shortcuts
vim.keymap.set("n", "<c-->", "<cmd>:split<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>:vsplit<cr>")

-- tab shortcuts
vim.keymap.set("n", "<c-t>", "<cmd>:tabnew %<cr>")

-- exit terminal mode
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>")

-- clear highlights after searching
vim.keymap.set("n", "<leader>/", "<cmd>:nohlsearch<cr>")

-- show messages
vim.keymap.set("n", "<leader>m", "<cmd>:messages<cr>")

local function bujo_edit(cmd)
  local spread = vim.fn.system(cmd)
  if spread == "" then
    vim.notify("Unable to open spread", vim.log.levels.ERROR)
  else
    vim.cmd("edit " .. spread)
  end
end

-- lazygit bindings
if is_tmux then
  vim.keymap.set("n", "<leader>lg", "<cmd>:silent !tmux new-window lazygit<cr>",
    { desc = "lazygit: Open in tmux window" })
else
  -- TODO: auto close terminal when lazygit exits
  vim.keymap.set("n", "<leader>lg", "<cmd>:silent terminal lazygit<cr>", { desc = "lazygit: Open in terminal" })
end

-- opencode bindings
if is_tmux then
  vim.keymap.set("n", "<leader>oc", "<cmd>:silent !tmux split-window -h opencode<cr>",
    { desc = "opencode: Open in tmux split" })
else
  vim.keymap.set("n", "<leader>oc", "<cmd>:silent vsplit | terminal opencode<cr>",
    { desc = "opencode: Open in terminal split" })
end

-- run bindings
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

-- bujo bindings
vim.keymap.set("n", "<leader>ns", function()
  -- TODO: this is going to have to call `bujo list` and pass it to a picker
  -- because `bujo search` can't run interactively
end, { desc = "Bujo: search documents" })
vim.keymap.set("n", "<leader>nn", function()
  bujo_edit("bujo spread current")
end, { desc = "Bujo: current spread" })
vim.keymap.set("n", "<leader>nf", function()
  bujo_edit("bujo spread next")
end, { desc = "Bujo: spread next" })
vim.keymap.set("n", "<leader>nF", function()
  local current_spread = vim.fn.expand("%:p")
  bujo_edit("bujo spread next " .. current_spread)
end, { desc = "Bujo: spread forward" })
vim.keymap.set("n", "<leader>nb", function()
  bujo_edit("bujo spread previous")
end, { desc = "Bujo: spread previous" })
vim.keymap.set("n", "<leader>nB", function()
  local current_spread = vim.fn.expand("%:p")
  bujo_edit("bujo spread previous " .. current_spread)
end, { desc = "Bujo: spread backward" })
vim.keymap.set("n", "<leader>nS", function()
  vim.loop.spawn('bujo', {
    args = { 'sync' },
  }, function(code)
    if code == 0 then
      vim.schedule(function()
        vim.notify("Bujo: sync complete 🎉", vim.log.levels.INFO)
      end)
    else
      vim.schedule(function()
        vim.notify("Bujo: sync failed 🥲", vim.log.levels.ERROR)
      end)
    end
  end)
end, { desc = "Bujo: sync" })

-- lsp format
vim.keymap.set("n", "grf", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP Format Document" })

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

-- toggle lsp inlay hints
vim.keymap.set("n", "grh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle LSP Inlay Hints" })

-- omni-omnifunc
vim.keymap.set("i", "<c-n>", function()
  if vim.fn.pumvisible() == 1 then return "<c-n>" else return "<c-x><c-o>" end
end, { expr = true, desc = "Trigger omnifunc or select next item in completion menu" })

-- copy path to clipboard
vim.api.nvim_create_user_command("CopyProjectPath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.keymap.set("n", "<leader>y", "<cmd>:CopyProjectPath<cr>")
vim.keymap.set("n", "<leader>Y", "<cmd>:CopyAbsolutePath<cr>")
