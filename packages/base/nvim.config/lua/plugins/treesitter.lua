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
      -- "bash",
      -- "make",
      -- "jq",
      -- "ssh_config",
      --
      -- "ledger",
      --
      -- "cmake",
      -- "c",
      -- "cpp",
      -- "glsl",
      -- "llvm",
      --
      -- "css",
      -- "dockerfile",
      --
      -- "gdscript",
      -- "gdshader",
      -- "godot_resource",
      --
      -- "git_config",
      -- "git_rebase",
      -- "gitattributes",
      -- "gitcommit",
      -- "gitignore",
      --
      -- "go",
      -- "gomod",
      -- "gosum",
      -- "gotmpl",
      -- "gowork",
      --
      -- "helm",
      -- "http",
      --
      -- "java",
      -- "kotlin",
      --
      -- "graphql",
      -- "javascript",
      -- "tsv",
      -- "tsx",
      -- "typescript",
      -- "vue",
      --
      -- "json",
      -- "toml",
      -- "yaml",
      --
      -- "html",
      -- "markdown",
      -- "markdown_inline",
      -- "regex",
      -- "scss",
      -- "sql",
      -- "xml",
      --
      -- "ruby",
      --
      -- "python",
      --
      -- "lua",
      -- "vim",
      --
      -- "perl",
      --
      -- "rust",
    }

    require("nvim-treesitter").install(ensure_installed)

    function _G.custom_fold_text()
      return vim.fn.getline(vim.v.foldstart)
    end

    vim.api.nvim_create_autocmd("FileType", {
      desc = "User: enable treesitter",
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

