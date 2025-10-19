vim.opt.autocomplete = false

vim.api.nvim_create_autocmd(
  { "BufHidden" },
  {
    callback = function()
      -- TODO: this will override the global setting if it is disabled. it would be ideal to cache the original state
      -- but having multiple prompts open at the same time would complicate that, so this is good enough for now
      vim.opt.autocomplete = true
    end,
  }
)
