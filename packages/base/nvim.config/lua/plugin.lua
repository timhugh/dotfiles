local lazy = {}

function lazy.install(path)
  if not (vim.uv or vim.loop).fs_stat(path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      path,
    })
  end
end

function lazy.setup()
  if vim.g.plugins_ready then
    return
  end

  local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  lazy.install(path)
  vim.opt.rtp:prepend(path)

  require("lazy").setup("plugins")
  vim.g.plugins_ready = true
end

return lazy
