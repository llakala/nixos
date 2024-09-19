{ hostVars, pkgs, ... }:

{
  users.users.${hostVars.username} =
  {
    isNormalUser = true;
    description = hostVars.fullName;

    initialPassword = " ";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  security.sudo.wheelNeedsPassword = false; # Passwordless sudo
}