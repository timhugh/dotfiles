local function bujo_edit(cmd)
  local spread = vim.fn.system(cmd)
  if spread == "" then
    vim.notify("Unable to open spread", vim.log.levels.ERROR)
  else
    vim.cmd("edit " .. spread)
  end
end
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
