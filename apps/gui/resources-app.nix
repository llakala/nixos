{ pkgs, config, ... }:

{

  environment.systemPackages = with pkgs;
  [
    resources
  ];

  hm.dconf.settings = assert config.features.desktop == "gnome";
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
      # Use mbps instead of mb/s
      network-bits = true;
      graph-data-points = 100;
      sidebar-details = true;

      apps-show-gpu-memory = false;

      processes-show-user = false;
      processes-show-id = false;
    };
  };
}
