# Thanks to Heisfer on github for a lot of this content
{ config, lib, pkgs, ... }:
let
  cfg = config.custom.programs.vesktop;
  jsonFormat = pkgs.formats.json { };
in
{
  options.custom.programs.vesktop =
  {
    enable = lib.mkEnableOption "a custom module for enabling and configuring Vesktop, a discord client";
    package = lib.mkPackageOption pkgs "vesktop" {};

    settings = lib.mkOption
    {
      type = jsonFormat.type;
      default = { };
      description =
      ''
        Vesktop settings written to
        `~/.config/vesktop/settings.json`. See
        <https://github.com/Vencord/Vesktop/blob/main/src/shared/settings.d.ts>
        for available options.
      '';
    };

    vencord.settings = lib.mkOption
    {
      type = jsonFormat.type;
      default = { };
      description = ''
        Vencord settings written to
        ~/.config/vesktop/settings/settings.json`. See
        <https://github.com/Vendicated/Vencord/blob/main/src/api/Settings.ts>
        for available options.
      '';
    };

  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = lib.singleton cfg.package;
    hm.xdg.configFile =
    {
      "vesktop/settings.json" = lib.mkIf (cfg.settings != { })
      {
        source = jsonFormat.generate "vesktop-settings.json" cfg.settings;
        force = true;
      };

      "vesktop/settings/settings.json" = lib.mkIf (cfg.vencord.settings != { })
      {
        source = jsonFormat.generate "vencord-settings.json" cfg.vencord.settings;
        force = true;
      };
    };
  };

}
