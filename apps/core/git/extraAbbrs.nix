{ config, ... }:
{
  hm.programs.fish.shellAbbrs =

  # Error if we ever change shell
  assert config.features.abbreviations == "fish";
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
