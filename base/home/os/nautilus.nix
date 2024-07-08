{ ... }:

{
  programs.nautilus-open-any-terminal =
  {
    enable = true;
    terminal = kgx; # TODO: Update if stop using gnome
  };

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
}