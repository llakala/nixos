{ lib, self, pkgs, ... }:

let
  fish-helix = self.legacyPackages.${pkgs.system}.fish-helix;
in {
  environment.systemPackages = lib.singleton fish-helix; # To give us the binary

  # To add the plugin data to `.config`
  hm.programs.fish.plugins = lib.singleton {
    name = "fish-helix";
    src = fish-helix;
  };

  # For setting keymap, use `fish_key_reader`
  # As of fish 4.0, this now uses more sane keybinding names - so update your
  # old binds to match the new style!
  hm.programs.fish.interactiveShellInit = # fish
  ''
    fish_vi_key_bindings

    # Not working very well on Fish 4.0: see https://github.com/sshilovsky/fish-helix/issues/9
    # fish_helix_key_bindings

    bind -M insert ctrl-space complete-and-search
    bind -M insert tab accept-autosuggestion
    bind -M insert ctrl-backspace backward-kill-bigword

    # Old Ctrl+C behavior, before 4.0
    bind -M insert ctrl-c cancel-commandline

    # Rerun previous command
    bind -M insert ctrl-s 'commandline $history[1]' 'commandline -f execute'
  '';
}
