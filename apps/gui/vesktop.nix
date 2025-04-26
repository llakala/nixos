{ inputs, lib, pkgs, ... }:

{
  features.discord = "vesktop"; # Change if we ever stop using vesktop

  hm.imports = lib.singleton inputs.nixcord.homeManagerModules.nixcord;

  # See https://github.com/KaylorBen/nixcord/blob/main/docs/main.md
  hm.programs.nixcord =
  {
    enable = true;

    # We don't need the normal discord client installed
    discord.enable = false;

    # New Vesktop version broken without this - see
    # https://github.com/NixOS/nixpkgs/pull/399932
    discord.vencord.package = pkgs.vencord.overrideAttrs (o: {
      postInstall =
        (o.postInstall or "")
        + ''
          cp package.json $out
        '';
    });

    vesktop.enable = true;
  };

  # See https://github.com/KaylorBen/nixcord/blob/main/docs/plugins.md
  hm.programs.nixcord.config.plugins =
  {
    betterSettings.enable = true;
    noUnblockToJump.enable = true;
    noReplyMention.enable = true;

    messageClickActions =
    {
      enable = true;
      enableDeleteOnClick = false;
    };

    # Sadly doesn't seem to be working
    noBlockedMessages =
    {
      enable = true;
      ignoreBlockedMessages = false;
    };
  };

  hm.xdg.configFile."vesktop/settings/settings.json" =
  {
    text = builtins.toJSON
    {
      discordBranch = "stable";
      minimizeToTray = false;
      arRPC = false;
      customTitleBar = false;
    };
    force = true;
  };
}
