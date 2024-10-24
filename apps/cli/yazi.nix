{ lib, config, inputs, pkgs-unstable, pkgs, ... }:

{

  hm = 
  {
    disabledModules = lib.singleton "${inputs.home-manager}/modules/programs/yazi.nix";
    imports = lib.singleton "${inputs.home-manager-unstable}/modules/programs/yazi.nix";
  };


  
  hm.programs.yazi =
  {
    enable = true;
    package = pkgs-unstable.yazi; # Can't use until I fix missing folder icon
  };

  hm.programs.yazi.settings = # yazi.toml settings, documented here https://yazi-rs.github.io/docs/configuration/yazi
  {
    opener.edit =
    [
      {
        run = ''${config.baseVars.editor} "$@" '';
        desc = "Open with the default editor.";
        block = true;
      }

      {
        run = ''code "$@" '';
        desc = "Open with VSCode.";
        block = true;
      }
    ];
  };

  hm.programs.yazi.keymap.manager.prepend_keymap =
  let
    wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy"; # We have it installed systemwide, but better safe than sorry
  in
  [
    {
      desc = "Open the selected files";
      on = lib.singleton "i"; # Same as "o" for open, but for my helix muscle memory
      run = "open";
    }
    {
      desc = "Go to the NixOS configuration directory";
      on = ["g" "n"]; 
      run = "cd ${config.baseVars.configDirectory}";
    }
    
    {
      desc = "Go to the projects folder for working on external Git repos";
      on = [ "g" "p" ];
      run = "cd ~/Documents/projects";
    }

    {
      desc = "Paste into the hovered directory or CWD";
      on = lib.singleton "p";
      run = "plugin --sync smart-paste";
    }

    {
      desc = "When copying, copy to the system clipboard as well";
      on = lib.singleton "y";
      run =
      [
        "yank"
        ''
          shell --confirm 'for path in "$@"; do echo "file://$path"; done | ${wl-copy} -t text/uri-list'
        ''
      ];
    }
  ];

  hm.programs.zsh.initExtra = # bash
  ''
    function y()
    {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      command yazi "$@" --cwd-file="$tmp" # Use `command yazi` to get around our yazi alias

      if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
      fi

      rm -f -- "$tmp"
    }
  '';

  environment.shellAliases.yazi = "echo 'USE y DUMMY'"; # We should always be using the `y` function, it's shorter and better

  # In xdg.configFile until #72 is done
  hm.xdg.configFile."yazi/plugins/smart-paste.yazi/init.lua".text = # lua
  ''
    return
    {
      entry = function()
        local h = cx.active.current.hovered
        if h and h.cha.is_dir then
          ya.manager_emit("enter", {})
          ya.manager_emit("paste", {})
          ya.manager_emit("leave", {})
        else
          ya.manager_emit("paste", {})
        end
      end,
    }
  '';


}
