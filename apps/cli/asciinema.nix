{ pkgs, ... }:

let
  toToml = (pkgs.formats.toml { }).generate;
in
{
  environment.systemPackages = with pkgs;
  [
    asciinema
  ];

  # Documented here https://docs.asciinema.org/manual/cli/configuration/
  hm.xdg.configFile."asciinema/config".source = toToml "config"
  {

  };

}
