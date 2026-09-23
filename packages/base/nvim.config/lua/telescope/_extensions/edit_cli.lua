return require("telescope").register_extension {
  exports = {
    projects = require("edit_cli").list_projects,
  },
}
