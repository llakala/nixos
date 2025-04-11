{

  services.xserver.displayManager.gdm =
  {
    enable = true;

    # Suspend doesn't work without this
    autoSuspend = true;
    banner = ":3 :3 :3";
  };



  # services.displayManager.autoLogin =
  # {
  #   enable = true;
  #   user = config.hostVars.username;
  # };

  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;
}
