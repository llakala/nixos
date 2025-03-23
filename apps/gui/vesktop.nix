{ inputs, lib, ... }:

{
  features.discord = "vesktop"; # Change if we ever stop using vesktop

  hm.imports = lib.singleton inputs.nixcord.homeManagerModules.nixcord;

  # See https://github.com/KaylorBen/nixcord/blob/main/docs/main.md
  hm.programs.nixcord =
  {
    enable = true;
    discord.enable = false;
    discord.vencord.unstable = false;
    vesktop.enable = true;
  };

  # See https://github.com/KaylorBen/nixcord/blob/main/docs/plugins.md
  hm.programs.nixcord.config.plugins =
  {
    betterSettings.enable = true;
    noUnblockToJump.enable = true;
    showAllMessageButtons.enable = true;

    messageClickActions =
    {
      enable = true;
      enableDeleteOnClick = false;
    };

    noBlockedMessages =
    {
      enable = true;
      ignoreBlockedMessages = false;
    };
  };
}
