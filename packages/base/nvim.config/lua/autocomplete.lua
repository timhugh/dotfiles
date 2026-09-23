vim.opt.complete = "F,o"
vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
vim.opt.autocomplete = true
vim.opt.autocompletedelay = 1000

vim.keymap.set("n", "<leader>ac", function()
  vim.opt.autocomplete = !vim.opt.autocomplete:get()
  vim.notify("Autocomplete " .. (vim.opt.autocomplete:get() and "enabled" or "disabled"), vim.log.levels.INFO)
end, { desc = "Toggle autocomplete" })

vim.keymap.set("i", "<c-n>", function()
  if vim.fn.pumvisible() == 1 then return "<c-n>" else return "<c-x><c-o>" end
end, { expr = true, desc = "Trigger omnifunc or select next item in completion menu" })

