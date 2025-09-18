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
  {
    "rcarriga/nvim-dap-ui",
    enabled = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  }
}
