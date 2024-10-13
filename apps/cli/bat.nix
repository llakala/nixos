{ lib, pkgs, ... }:

{
  environment.shellAliases.cat = "bat";
  environment.shellAliases.man = "batman";

  hm.programs.bat =
  {
    enable = true;

    extraPackages = with pkgs.bat-extras;
    [
      batman # Prettier version of man
    ];
  };

  environment.variables = # Make --help look pretty like batman
  {
    MANPAGER = "sh -c 'col -bx | bat --language man --plain' ";
    MANROFFOPT = "-c";
  };

  hm.home.activation.batCache = lib.mkForce "";# Waiting for https://github.com/nix-community/home-manager/issues/5481 is fixed
}
