require('lsp').configure_lsp('ruby_lsp', {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = 'auto',
  },
  on_attach = function()
    -- for some reason the tagfunc doesn't seem to work for ruby_lsp
    -- so this is kind of a brute force way to get "go to definition" working
    vim.keymap.set("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true, desc = "Go to definition" })
  end,
})
