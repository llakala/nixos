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
    "/git"
    "/gh"
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
  options.abbreviations = {
    type = types.string;
    mutable = true;
    mutator = {
      type =
        let
          abbrWithCursor = types.struct "abbrWithCursor" {
            setCursor = types.bool;
            expansion = types.string;
          };
        in
        types.attrsOf (types.union [
          types.string
          (abbrWithCursor.override { unknown = false; })
        ]);
      mergeFunc =
        { mutators, inputs }:
        let
          inherit (builtins) isString concatLists concatStringsSep;
          inherit (inputs.nixpkgs.lib) mapAttrsToList;
          # We use wrapping single quotes around our abbrs, so replace any
          # internal single quotes if they exist
          escapeSingleQuotes = str: builtins.replaceStrings [ "'" ] [ "\\'" ] str;
          abbrToString =
            input: output:
            if isString output then
              "abbr --add -- ${input} '${escapeSingleQuotes output}'"
            else if output.setCursor == true then
              "abbr --add --set-cursor -- ${input} '${escapeSingleQuotes output.expansion}'"
            else
              "abbr --add -- ${input} '${escapeSingleQuotes output.expansion}'";
          moduleToAbbrList = _: module: mapAttrsToList abbrToString module;
          allAbbrs = concatLists (mapAttrsToList moduleToAbbrList (
            mutators // { "/fish" = import ./abbreviations.nix; })
          );
        in
        concatStringsSep "\n" allAbbrs;
    };
  };
  options.interactiveShellInit = {
    type = types.derivation;
    mutable = true;
    mutator = {
      type = types.string;
      mergeFunc =
        { mutators, inputs, options }:
        let
          inherit (builtins) readFile attrValues concatStringsSep;
          inherit (inputs.nixpkgs.pkgs) writeText;
          # Append the extra shell init from each of the mutators after our
          # "base" config, with newlines in between
          mergedFishConfig = concatStringsSep "\n" (
            [
              (readFile ./config.fish)
              (options.abbreviations)
            ]
            ++ attrValues mutators
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
