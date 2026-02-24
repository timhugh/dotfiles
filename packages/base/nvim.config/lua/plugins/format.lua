return {
  {
    'sbdchd/neoformat',
    config = function()
      vim.g.neoformat_enabled_javascript = { 'prettier', 'eslint_d' }
      vim.g.neoformat_only_msg_on_error = 1
      vim.g.neoformat_try_node_exe = 1
    end,
  }
}
