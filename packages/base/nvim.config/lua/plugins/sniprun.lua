return {
  {
    "michaelb/sniprun",
    enabled = true,
    lazy = true,
    event = "VeryLazy",
    branch = "master",
    build = "cargo build --release",
    cmd = { "SnipRun" },
    keys = {
      { "<leader>r", "<cmd>SnipRun<cr>", desc = "SnipRun: Run code block", mode = { "n", "v" } },
    },
    opts = {
      selected_interpreters = {
        "JS_TS_deno",
      },
      repl_enable = {
        "JS_TS_deno",
      },
    },
  },
}
