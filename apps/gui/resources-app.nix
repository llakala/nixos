{ pkgs, config, lib, ... }:

{
  environment.systemPackages = with pkgs;
  [
    resources
  ];

  hm.dconf.settings = lib.mkIf (config.features.desktop == "gnome")
  {
    # Ctrl+Alt+Delete to open Resources
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings =
    [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-resources/"
    ];
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-resources" =
    {
      binding = "<Control><Alt>Delete";
      command = "resources";
      name = "Open Resources";
    };


    "net/nokyan/Resources" =
    {
      network-bits = true; # Use mbps instead of mb/s
      graph-data-points = 100;
      sidebar-details = true;

      apps-show-gpu-memory = false;

      processes-show-user = false;
      processes-show-id = false;
    };
  };
}
