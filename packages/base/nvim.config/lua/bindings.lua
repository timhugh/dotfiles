vim.g.mapleader = ","

vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>")

-- split shortcuts
vim.keymap.set("n", "<leader>-", "<cmd>:split<cr>")

vim.keymap.set("n", "<leader>\\", "<cmd>:vsplit<cr>")

-- tab shortcuts
vim.keymap.set("n", "<c-t>", "<cmd>:tabnew %<cr>")
vim.keymap.set("n", "<c-m-t>", "<cmd>:tabnew | terminal<cr>")

-- open terminal
vim.keymap.set("n", "<leader>t", "<cmd>:terminal<cr>")
--
-- exit terminal mode
vim.keymap.set("t", "<ESC>", "<c-\\><c-n>")

-- navigating splits
vim.keymap.set("n", "<m-h>", "<c-w>h")
vim.keymap.set("t", "<m-h>", "<c-\\><c-n><c-w>h")

vim.keymap.set("n", "<m-j>", "<c-w>j")
vim.keymap.set("t", "<m-j>", "<c-\\><c-n><c-w>j")

vim.keymap.set("n", "<m-k>", "<c-w>k")
vim.keymap.set("t", "<m-k>", "<c-\\><c-n><c-w>k")

vim.keymap.set("n", "<m-l>", "<c-w>l")
vim.keymap.set("t", "<m-l>", "<c-\\><c-n><c-w>l")

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
  handle = vim.loop.spawn('bujo', {
    args = { 'sync' },
  }, function(code, signal)
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
