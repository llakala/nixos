{ config, lib, inputs, pkgs, ... }:

{
  imports =
  [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" config.hostVars.username]) # Let us use hm as shorthand for home-manager config
  ];

  environment.systemPackages = with pkgs;
  [
    home-manager # Lets us run commands like `home-manager switch`
  ];

  hm =
  {

    programs.home-manager =
    {
      enable = true;
    };

    home =
    {
      username = config.hostVars.username;
      homeDirectory = config.hostVars.homeDirectory;
      stateVersion = config.hostVars.stateVersion;
    };
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

}
