{ hostVars, ... }:


{

  services.xserver.displayManager. gdm.enable = true;


  # services.displayManager.autoLogin =
  # {
  #   enable = true;
  #   user = hostVars.username;
  # };

  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;
}