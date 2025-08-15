return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter').install()
  end,
  init = function()
    local ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "dockerfile",
      "gdscript",
      "gdshader",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "glsl",
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gowork",
      "graphql",
      "helm",
      "html",
      "http",
      "java",
      "javascript",
      "jq",
      "json",
      "kotlin",
      "ledger",
      "llvm",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "perl",
      "python",
      "regex",
      "ruby",
      "rust",
      "scss",
      "sql",
      "ssh_config",
      "terraform",
      "toml",
      "tsv",
      "tsx",
      "typescript",
      "vim",
      "vue",
      "xml",
      "yaml",
    }

    require("nvim-treesitter").install(ensure_installed)

    function _G.custom_fold_text()
      return vim.fn.getline(vim.v.foldstart)
    end

    vim.api.nvim_create_autocmd("FileType", {
      desc = "User: enable treesitter highlighting",
      callback = function(ctx)
        local hasStarted = pcall(vim.treesitter.start)

        local noIndent = {}
        if hasStarted and not vim.list_contains(noIndent, ctx.match) then
          vim.opt.foldmethod = "expr"
          vim.opt.foldlevel = 99
          vim.opt.foldlevelstart = 99
          vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.opt.foldtext = ''
        end
      end,
    })
  end,
}

