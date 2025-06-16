return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        names = false,
        tailwind = true,
        tailwind_opts = {
          update_names = true,
        },
      },
    },
    config = function(opts)
      require("colorizer").setup({opts})
    end,
  }
}
