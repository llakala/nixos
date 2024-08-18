 { hostVars, lib, ... }:


{

  services.xserver.displayManager.gdm =
  {
    enable = true;
    banner = ":3 :3 :3";
  };

  programs.dconf.profiles.gdm.databases = # dconf options from nixos, NOT home-manager
  [
    {
      settings =
      {
        "org/gnome/desktop/interface" = # Scaling on login screen
        {
          scaling-factor = lib.gvariant.mkUint32 hostVars.scalingFactor;
        };
      };
    }
  ];



  # services.displayManager.autoLogin =
  # {
  #   enable = true;
  #   user = hostVars.username;
  # };

  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;
}