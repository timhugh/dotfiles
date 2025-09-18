return {
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    config = function()
      local dap = require("dap")
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }

      vim.keymap.set("n", "<leader>dd", "<cmd>:DapNew<cr>")
      vim.keymap.set("n", "<leader>dD", "<cmd>:DapTerminate<cr>")
      vim.keymap.set("n", "<leader>dc", "<cmd>:DapContinue<cr>")
      vim.keymap.set("n", "<leader>db", "<cmd>:DapToggleBreakpoint<cr>")
      vim.keymap.set("n", "<leader>dn", "<cmd>:DapStepOver<cr>")
      vim.keymap.set("n", "<leader>di", "<cmd>:DapStepInto<cr>")
      vim.keymap.set("n", "<leader>do", "<cmd>:DapStepOut<cr>")
      vim.keymap.set("n", "<leader>dr", "<cmd>:DapToggleRepl<cr>")
    end,
  },
}
