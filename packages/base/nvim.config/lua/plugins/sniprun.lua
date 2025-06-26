return {
  {
    "michaelb/sniprun",
    enabled = true,
    lazy = true,
    event = "VeryLazy",
    branch = "master",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    keys = {
      { "<leader>r", "<cmd>SnipRun<cr>", desc = "SnipRun: Run code block", mode = { "n", "v" } },
    },
    opts = {},
  },
}
