{
  hm.programs.plasma.configFile = {
    baloofilerc."Basic Settings".Indexing-Enabled = false;
  };
  systemd.user.services.plasma-kaccess = {
    enable = false;
  };
  services.geoclue2.enable = false;
}
