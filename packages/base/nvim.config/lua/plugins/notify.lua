return {
  {
    "rcarriga/nvim-notify",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.notify = require("notify")

      require('telescope').load_extension('notify')
    end,
  },
}
