{ config, ... }:
{
  hm.programs.plasma.configFile.kdeglobals.General =
  assert config.features.usingKittab == true;
  {
    TerminalApplication = "kittab";
    TerminalService = "kittab.desktop";
  };
}
