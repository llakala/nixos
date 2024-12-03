{ lib, pkgs, config, ... }:

let
  lessOptions = config.programs.less.envVariables.LESS; # Reuse the LESS options we want to be used everywhere
in
{
  environment.shellAliases.man = "batman";

  hm.programs.bat =
  {
    enable = true;

    config = # List of command line options to supply every time
    {
      style = "plain";
      pager = "${lib.getExe pkgs.less} ${lessOptions}";
    };

    extraPackages = with pkgs.bat-extras;
    [
      batman # Prettier version of man
      batdiff
      batgrep # Oddly seems to require sudo
    ];
  };

  environment.variables = # Make --help look pretty like batman
  {
    MANPAGER = "sh -c 'col -bx | bat --language man' ";
    MANROFFOPT = "-c";
  };

  hm.home.activation.batCache = lib.mkForce "";# Waiting for https://github.com/nix-community/home-manager/issues/5481 is fixed
}
