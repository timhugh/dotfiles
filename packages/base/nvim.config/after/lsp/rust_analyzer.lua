return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  on_attach = function(client, bufnr)
    require('core.lsp').on_attach(client, bufnr)
  end,
}
