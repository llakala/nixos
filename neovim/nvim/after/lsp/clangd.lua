---@type vim.lsp.Config
return {
  -- These are _way_ too slow
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  -- `settings` and `init_options` refuse to work for me
  cmd = {
    "clangd",
    "--function-arg-placeholders=0",
  },
}
