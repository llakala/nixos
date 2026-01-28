_:
{
  options = {
    settingsFile.default = ./yazi.toml;
    keymapFile.default = ./keymap.toml;
    initLuaFile.default = ./init.lua;

    extraPackages.defaultFunc = { inputs }: import ./extraPackages.nix { inherit inputs; };
    plugins.defaultFunc = { inputs }: import ./plugins.nix { inherit inputs; };
  };

  mutations = {
    "/fish".interactiveShellInit =
      _:
      /* fish */
      ''
        # When pressing Ctrl+y, go to the last directory we were in with Yazi
        # Yazi recommends an alternative where you run `$shell` and it goes into
        # fish, but then I don't get Ctrl+z to resume the process
        bind \cy 'cd (cat /tmp/yazi-cwd-suspend); commandline -f repaint'

        # From https://github.com/yazi-rs/yazi-rs.github.io/blob/92b34e7dc31b025724a9eb5f5ce8b63268ce5b87/docs/quick-start.md?plain=1#L40
        function y
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        end
      '';
  };
}
