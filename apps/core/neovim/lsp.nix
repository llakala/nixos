{ pkgs, lib, config, ... }:

let
  flake = "(builtins.getFlake \"${config.baseVars.configDirectory}\")";
  hostOptions = flake + ".nixosConfigurations.${config.hostVars.hostName}.options";
in
{
  hm.programs.neovim.plugins = lib.singleton pkgs.vimPlugins.nvim-lspconfig;
  hm.programs.neovim.extraLuaConfig =
  /* lua */
  ''
    require("lspconfig").nixd.setup({
      cmd =
      {
        "${lib.getExe pkgs.nixd}",
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
}
