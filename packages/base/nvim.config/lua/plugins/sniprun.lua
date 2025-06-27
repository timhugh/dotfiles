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
      { "<leader>rr", "<cmd>SnipRun<cr>", desc = "SnipRun: Run code block", mode = { "n" } },
      { "<leader>rc", "<cmd>SnipClose<cr>", desc = "SnipRun: Close outputs", mode = { "n" } },
      { "<leader>rK", "<cmd>SnipReset<cr>", desc = "SnipRun: Stop", mode = { "n" } },
    },
    opts = {
      display = {
        "VirtualLine",
      },
      selected_interpreters = {
        "JS_TS_deno",
        "Lua_nvim",
      },
      repl_enable = {
        "JS_TS_deno",
        "Lua_nvim",
        "Ruby_original",
      },
    },
  },
}
