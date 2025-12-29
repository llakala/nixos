{ adios }:
let
  inherit (adios) types;
in {
  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    settingsFile = {
      type = types.path;
      default = ./yazi.toml;
    };
    keymapFile = {
      type = types.path;
      default = ./keymap.toml;
    };
    initLua = {
      type = types.path;
      default = ./init.lua;
    };

    extraPackages = {
      type = types.listOf types.derivation;
      defaultFunc = { inputs }: import ./extraPackages.nix { inherit inputs; };
    };
    plugins = {
      type = types.attrsOf (types.union [ types.path types.derivation ]);
      defaultFunc = { inputs }: import ./plugins.nix { inherit inputs; };
    };

    configDir = {
      type = types.derivation;
      defaultFunc =
        { inputs, options }:
        let
          inherit (inputs.nixpkgs) pkgs lib;
          inherit (lib) mapAttrsToList;
          inherit (pkgs) linkFarm;
        in
        linkFarm "yazi-config" ([
          { name = "yazi/yazi.toml"; path = options.settingsFile; }
          { name = "yazi/keymap.toml"; path = options.keymapFile; }
          { name = "yazi/init.lua"; path = options.initLua; }
        ]
        ++ mapAttrsToList (name: path: {
          name = "yazi/plugins/${name}";
          inherit path;
        }) options.plugins);
    };
  };

  mutations."/fish".interactiveShellInit =
    _:
    # fish
    ''
      # When pressing Ctrl+y, go to the last directory we were in with Yazi
      # Yazi recommends an alternative where you run `$shell` and it goes into
      # fish, but then I don't get Ctrl+z to resume the process
      bind -M insert \cy 'cd (cat /tmp/yazi-cwd-suspend); commandline -f repaint'

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

  impl =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) pkgs lib;
      inherit (lib) makeBinPath;
    in
    inputs.mkWrapper {
      package = pkgs.yazi-unwrapped;
      extraPaths = [ options.configDir ];
      wrapperArgs = ''
        --prefix PATH : ${makeBinPath options.extraPackages}
      '';
      environment = {
        YAZI_CONFIG_HOME = "$out/yazi";
      };
    };
}
