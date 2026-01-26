return {
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      copilot_node_command = {"mise", "x", "node@lts", "--", "node" },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-Tab>",
        },
      },
      panel = {
        enabled = false,
      },
      nes = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept_and_goto = "<S-M-Tab>",
        },
      },
      filetypes = {
        markdown = false,
        ["*"] = true,
      },
    },
  },
  {
    "copilotlsp-nvim/copilot-lsp",
    enabled = false,
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },
}
