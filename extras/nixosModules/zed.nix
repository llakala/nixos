{ config, lib, pkgs, ... }:

let
  cfg = config.custom.programs.zed-editor;

  settingsFormat = pkgs.formats.json { };
in {
  options.custom.programs.zed-editor = {
    enable = lib.mkEnableOption "Zed, a text editor.";
    package = lib.mkPackageOption pkgs "zed-editor" { };

    settings = lib.mkOption {
      type = settingsFormat.type;
      description = ''
        Configuration settings to be put in {file}`$XDG_CONFIG_HOME/zed/settings.json`}.
      '';
      default = { };
      example = {
        "autosave" = "off";
        "confirm_quit" = true;
      };
    };

  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    hm.xdg.configFile."zed/settings.json".source = settingsFormat.generate "zed-settings" cfg.settings;
    hm.xdg.configFile."zed/settings.json".force = true;
  };
}
