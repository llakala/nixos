{ lib, self, pkgs, ... }:

let
  fish-helix = self.packages.${pkgs.system}.fish-helix;
in
{
  environment.systemPackages = lib.singleton fish-helix; # To give us the binary

  # To add the plugin data to `.config`
  hm.programs.fish.plugins = lib.singleton
  {
    name = "fish-helix";
    src = fish-helix;
  };

  # For setting keymap, use `fish_key_reader`
  hm.programs.fish.interactiveShellInit =
  /* fish */
  ''
    fish_vi_key_bindings # fish-helix expects this to be set or it breaks
    fish_helix_key_bindings

    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore
    set fish_cursor_visual      underscore blink
    '';
}
