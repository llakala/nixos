{ adios }:
let
  inherit (adios) types;
in {
  name = "fish";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  mutators = [
    "/fzf"
    "/kitty"
    "/starship"
    "/yazi"
    "/zoxide"
  ];

  options.functions = {
    type = types.path;
    default = ./functions;
  };
  options.completions = {
    type = types.path;
    default = ./completions;
  };
  options.interactiveShellInit = {
    type = types.derivation;
    mutable = true;
    mutator = {
      type = types.string;
      mergeFunc =
        { mutators, inputs }:
        let
          inherit (builtins) readFile attrValues concatStringsSep;
          inherit (inputs.nixpkgs.pkgs) writeText;
          # Append the extra shell init from each of the mutators after our
          # "base" config, with newlines in between
          mergedFishConfig = concatStringsSep "\n" (
            [ (readFile ./config.fish) ] ++ attrValues mutators
          );
        in
        writeText "config.fish" mergedFishConfig;
    };
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) symlinkJoin;
      in
      symlinkJoin {
        name = "fish-wrapped";
        paths = [ pkgs.fish ];
        postBuild = /* bash */ ''
          rm -r $out/share/fish/vendor_completions.d $out/share/fish/vendor_functions.d
          ln -s ${options.completions} $out/share/fish/vendor_completions.d
          ln -s ${options.functions} $out/share/fish/vendor_functions.d
          ln -s ${options.interactiveShellInit} $out/share/fish/vendor_conf.d/config.fish
        '';
        meta.mainProgram = "fish";
      };
  };
}
