{ vars, ... }:

{
  dconf.settings =
  {
   "org/gtk/gtk4/settings/file-chooser" =
    {
      show-hidden = true;
    };

    "org/gtk/settings/file-chooser" =
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
}