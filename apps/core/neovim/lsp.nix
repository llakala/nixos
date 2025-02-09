{ pkgs, pkgs-unstable, lib, config, ... }:

let
  flake = "(builtins.getFlake \"${config.baseVars.configDirectory}\")";
  hostOptions = flake + ".nixosConfigurations.${config.hostVars.hostName}.options";
in
{
  hm.programs.neovim.plugins = lib.singleton
  {
    plugin = pkgs.vimPlugins.nvim-lspconfig;
    type = "lua";
    config =
    /* lua */
    ''
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

      require("lspconfig").nixd.setup({
        cmd =
        {
          "${lib.getExe pkgs-unstable.nixd}",
          "--inlay-hints=false",
          "-semantic-tokens=true" -- NEEDED, makes syntax highlighting much better
        },
        -- settings.nixd =
        -- {
        --  nixpkgs.expr = "import <nixpkgs> { }",
        --   options.nixos.expr = "${hostOptions}",
        -- },
      })
    '';
  };
}
