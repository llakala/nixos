{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs;
  [
    nvd
  ];

  system.activationScripts.diff = # Runs on every rebuild. Used instead of diff-closures because output is more detailed
  # bash
  ''
   ${pkgs.nvd}/bin/nvd --color=always --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
  '';
}
