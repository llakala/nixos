-- Dynamically resolve the TypeScript compiler SDK path
local function resolve_tsdk()
  local local_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
  if vim.uv.fs_stat(local_ts) then
    return local_ts
  end

  -- Shell environment variable override
  return os.getenv("ASTRO_TSDK_PATH")
end

---@type vim.lsp.Config
return {
  -- Astro strictly requires the TypeScript SDK path at startup
  ---@type table
  init_options = {
    typescript = {
      tsdk = resolve_tsdk(),
    },
  },
}
