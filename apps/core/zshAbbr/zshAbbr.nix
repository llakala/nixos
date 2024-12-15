{ config, lib, inputs, pkgs-unstable, ... }:

{
  hm = # Use unstable home-manager module for package option
  {
    disabledModules = lib.singleton "${inputs.home-manager}/modules/programs/zsh/zsh-abbr.nix";
    imports = lib.singleton "${inputs.home-manager-unstable}/modules/programs/zsh/zsh-abbr.nix";
  };

  environment.variables =
  {
    ABBR_SET_EXPANSION_CURSOR = 1; # Enable % syntax
  };

  hm.programs.zsh.zsh-abbr =
  {
    enable = true;
    package = pkgs-unstable.zsh-abbr; # 6.0 is dropping on unstable soon
    abbreviations =
    {
      cdn = "cd ${config.baseVars.configDirectory}";

      m = "man";
      py = "python";

      src = "source";
    };
  };
}
