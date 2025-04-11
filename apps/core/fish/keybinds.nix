{ lib, self, pkgs, ... }:

let
  fish-helix = self.legacyPackages.${pkgs.system}.fish-helix;
in
{
  # To give us the binary
  environment.systemPackages = lib.singleton fish-helix;

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

    # fish-helix expects this to be set or it breaks
    fish_vi_key_bindings
    fish_helix_key_bindings

    # Ctrl+Space
    bind -M insert -k nul complete-and-search

    # Tab
    bind -M insert \t accept-autosuggestion

    # Ctrl+Backspace
    bind -M insert \b backward-kill-bigword

    # Ctrl+S to rerun previous command
    bind -M insert \cS 'commandline $history[1]' 'commandline -f execute'
  '';
}
