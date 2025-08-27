return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.git' },
  on_attach = function(client, bufnr)
    -- luals has an annoying habit of removing newlines when formatting ranges so we're just going to disable formatting for now
    -- TODO: either fix the autoformat functionality or find a better way to handle this
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- TODO: this is running after the on_attach function in core/lsp.lua (unsurprisingly) so the format_changed_hunks callback
    -- is being registered anyway, even though we disabled formatting here.
    -- We need to find a way to attach the format_changed_hunks callback _after_ this on_attach has run, and that might just be
    -- something like explicitly calling it in the on_attach functions for every LSP's config? Or providing a default on_attach
    -- implementation for all LSPs
    -- vim.notify('on_attach for lua_ls called for buffer ' .. bufnr, vim.log.levels.INFO)
  end,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}
