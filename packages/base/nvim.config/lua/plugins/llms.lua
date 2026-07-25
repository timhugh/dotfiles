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
      copilot_node_command = { "mise", "x", "node@lts", "--", "node" },
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
      filetypes = {
        markdown = false,
        ["*"] = true,
      },
    },
  },
}
