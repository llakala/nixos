{ config, ... }:
{
  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviationsProvider == "fish"; # Error if we ever change shell
  {
    gpr = "git pr";
    gpru =
    {
      setCursor = true;
      expansion = "git pr % upstream";
    };

    gud = "git undo";
  };

}
