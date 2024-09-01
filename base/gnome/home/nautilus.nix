{ vars, hostVars, ... }:

{
  dconf.settings =
  {
   "org/gtk/gtk4/settings/file-chooser" = # Within Nautilus
    {
      show-hidden = true;
    };

    "org/gtk/settings/file-chooser" = # When downloading files
    {
      show-hidden = true;
    };
  };

  gtk =
  {
    enable = true;
    gtk3.bookmarks =
    [
      "file:///" # Root
      "file://${vars.configDirectory}" # nixos config directory
    ];
  };

  xdg.userDirs = # Delete useless directories from nautilus settings
  {
    enable = true;
    createDirectories = true;

    music = null;
    pictures = "${hostVars.homeDirectory}/Screenshots";
    videos = "${hostVars.homeDirectory}/VMs"; # We can't define custom userDirs easily, so just make videos point to VMs. since we'd never use videos anyway
    documents = null;

    # vms = "${hostVars.homeDirectory}/VMs";
  };
}