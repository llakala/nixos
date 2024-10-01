{ pkgs-unstable, config, ... }:

{
  system.activationScripts.diff = ''
   ${pkgs-unstable.nvd}/bin/nvd --color=always --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
  '';
}