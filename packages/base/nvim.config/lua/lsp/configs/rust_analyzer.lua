require('lsp').configure_lsp('rust_analyzer', {
  enabled = true,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
})
