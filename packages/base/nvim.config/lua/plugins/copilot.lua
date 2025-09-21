return {
  {
    "zbirenbaum/copilot.lua",
    -- "timhugh/copilot.lua",
    -- branch = "timheuett/nodejs-commands",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      copilot_node_command = {"mise", "x", "node@lts", "--", "node" },
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<c-y>",
        refresh = "gr",
        open = "<M-CR>",
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
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
