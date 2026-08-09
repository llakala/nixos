vim.keymap.del("n", "grn")
-- This is just ascii stuff by default - useless to me!
vim.keymap.del({ "n", "x" }, "gra")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local args = { buf = event.buf }
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    vim.lsp.inlay_hint.enable(true)

    vim.diagnostic.config({
      virtual_text = false, -- Have this through a plugin
      severity_sort = true,
      signs = false,
      float = {
        border = "rounded",
      },
    })

    -- Replace mode is stupid, and nobody sane would ever use it. If neovim can
    -- change K, I can change R.
    vim.keymap.set("n", "R", function()
      vim.g.input_normal_mode = true
      vim.lsp.buf.rename()
    end, args)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, args)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, args)
    vim.keymap.set("n", "grd", vim.diagnostic.setloclist, args)
    vim.keymap.set("n", "grD", vim.diagnostic.setqflist, args)

    vim.keymap.set({ "n", "x" }, "ga", vim.lsp.buf.code_action, args)

    if client and client.server_capabilities.selectionRangeProvider then
      -- Prefer lsp-based incremental selection if it exists
      vim.keymap.set("x", "<CR>", function()
        vim.lsp.buf.selection_range(vim.v.count1)
      end, args)
      vim.keymap.set("x", "<BS>", function()
        vim.lsp.buf.selection_range(vim.v.count1)
      end, args)
    elseif vim.treesitter.get_parser(nil, nil, { error = false }) then
      vim.keymap.set("x", "<CR>", function()
        vim.treesitter.select("parent", vim.v.count1)
      end, args)
      vim.keymap.set("x", "<BS>", function()
        vim.treesitter.select("child", vim.v.count1)
      end, args)
    end
  end,
})
