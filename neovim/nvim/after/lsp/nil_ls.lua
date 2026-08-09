---@type vim.lsp.Config
return {
  on_init = function(client)
    -- This gives basically equivalent results to treesitter, but with a few
    -- annoying bugs
    client.server_capabilities.selectionRangeProvider = nil
  end,
  settings = {
    ["nil"] = {
      nix = {
        flake = {
          autoArchive = false,
          autoEvalInputs = false,
        },
      },
    },
  },
}
