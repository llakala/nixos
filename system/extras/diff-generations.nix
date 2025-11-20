{ pkgs, config, lib, ... }:

{
  # Runs on every rebuild. Used instead of diff-closures because output is more detailed
  # Logs go fast, but I believe `-e /run/current-system` makes sure that we're actually
  # in an interactive session, and not just booting up
  system.activationScripts.diff = # bash
  ''
    if [[ -e /run/current-system ]]; then
      ${lib.getExe pkgs.nvd} --color=always --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
    fi
  '';
}
