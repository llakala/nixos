{ pkgs, pkgs-unstable, ... }:

let
  toToml = (pkgs.formats.toml { }).generate;
in
{
  environment.systemPackages = with pkgs-unstable;
  [
    asciinema_3
  ];

  # Documented here https://docs.asciinema.org/manual/cli/configuration/
  hm.xdg.configFile."asciinema/config".source = toToml "config"
  {

  };

}
