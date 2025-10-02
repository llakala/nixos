{ config, lib, pkgs, ... }:

let
  cfg = config.custom.hardware.framework-laptop;
  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.custom.hardware.framework-laptop = {
    keyboardBacklight = {
      enable = mkEnableOption "keyboard backlight control";
      brightness = mkOption {
        type = types.int;
        description = "Brightness of the keyboard backlight (0-100)";
      };
    };

    fingerprintBacklight = {
      enable = mkEnableOption "fingerprint sensor backlight control";
      brightness = mkOption {
        type = types.enum [ "low" "medium" "high" ];
        description = "Brightness of the fingerprint sensor LED";
      };
    };

    chargeLimit = {
      enable = mkEnableOption "artificially limiting the maximum battery percentage to extend battery lifespan";
      percentage = mkOption {
        type = types.int;
        description = "The maximum percentage the battery can charge to (25-100)";
      };
    };
  };
  config = {
    environment.systemPackages =
      mkIf (cfg.keyboardBacklight.enable || cfg.fingerprintBacklight.enable || cfg.chargeLimit.enable)
      [ pkgs.framework-tool ];

    systemd.services = {
      framework-keyboard-backlight = mkIf cfg.keyboardBacklight.enable {
        description = "Set keyboard backlight brightness on Framework laptop";
        wantedBy = [ "multi-user.target" ];
        after = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart =  "${pkgs.framework-tool}/bin/framework_tool --kblight ${toString cfg.keyboardBacklight.brightness}";
        };
      };

      framework-fingerprint-backlight = mkIf cfg.fingerprintBacklight.enable {
        description = "Set fingerprint sensor LED brightness on Framework laptop";
        wantedBy = [ "multi-user.target" ];
        after = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart =  "${pkgs.framework-tool}/bin/framework_tool --fp-brightness ${cfg.fingerprintBacklight.brightness}";
        };
      };

      framework-charge-limit = mkIf cfg.chargeLimit.enable {
        description = "Set battery charge limit on Framework laptop";
        wantedBy = [ "multi-user.target" ];
        after = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart =  "${pkgs.framework-tool}/bin/framework_tool --charge-limit ${toString cfg.chargeLimit.percentage}";
        };
      };
    };
  };
}
