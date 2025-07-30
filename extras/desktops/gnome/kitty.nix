{ lib, config, ... }:

let
  onGnome = (config.features.desktop == "gnome");
  usingKitty = (config.features.terminal == "kitty");
in
{
  # Only apply this if we're actually using kitty
  hm.programs.kitty.settings = lib.mkIf onGnome
  (
    # If we are using Gnome and this applies, we should be using Kitty! Error if
    # false, unlike above, where we're fine if it's false.
    assert usingKitty;
    {
      # Make titlebar normal gnome titlebar rather than ugly kitty one
      linux_display_server = "x11";
    }
  );
}
