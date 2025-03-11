if vim.g.vscode then
else
    require("core.options")
    require("core.mappings")
    require("core.lazy").setup()
end
