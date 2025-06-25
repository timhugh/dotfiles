return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enabled = true,
    opts = {
      cmake_compile_commands_options = {
        action = "none",
      },
      cmake_regenerate_on_save = false,
    },
  },
}
