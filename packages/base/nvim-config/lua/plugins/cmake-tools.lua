return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    cmake_generate_options = {
      "-DBUILD_TESTING=ON",
      "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
      "-DCMAKE_BUILD_TYPE=Debug",
    },
    cmake_build_directory = "build",
  },
}

