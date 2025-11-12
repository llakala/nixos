{ config, ... }:

{
  programs.direnv = {
    enable = true;
    silent = true;

    nix-direnv.enable = true;
  };

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; {
    ndr = "nix-direnv-reload";
  };
}
