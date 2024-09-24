{
  hostVars,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports =
  [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" hostVars.username]) # Let us use hm as shorthand for home-manager config
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
      username = hostVars.username;
      homeDirectory = hostVars.homeDirectory;
      stateVersion = hostVars.stateVersion;
    };
  };

  home-manager.useUserPackages = lib.mkForce false; # Breaks everything
  home-manager.useGlobalPkgs = true;

}