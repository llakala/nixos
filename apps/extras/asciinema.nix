{ pkgs, pkgs-unstable, lib, ... }:

let
  toToml = (pkgs.formats.toml { }).generate;
in
{
  environment.systemPackages = lib.singleton pkgs-unstable.asciinema_3;


  # Documented here https://docs.asciinema.org/manual/cli/configuration/
  hm.xdg.configFile."asciinema/config".source = toToml "config"
  {

  };

}
