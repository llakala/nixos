{ lib, pkgs, config, ... }:

let
  # Reuse the LESS options we want to be used everywhere
  lessOptions = config.programs.less.envVariables.LESS;
in
{
  environment.shellAliases.man = "batman";

  hm.programs.bat =
  {
    enable = true;

    # List of command line options to supply every time
    config =
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

  # Waiting for https://github.com/nix-community/home-manager/issues/5481 to be fixed
  hm.home.activation.batCache = lib.mkForce "";
}
