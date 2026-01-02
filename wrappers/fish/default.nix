{ adios }:
let
  inherit (adios) types;
in {
  name = "fish";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    functions = {
      type = types.path;
      default = ./functions;
    };
    completions = {
      type = types.path;
      default = ./completions;
    };
    abbreviations = {
      mutators = [ "/gh" "/git" ];
      type = types.string;
      mutatorType =
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
    interactiveShellInit = {
      mutators = [ "/fzf" "/kitty" "/starship" "/yazi" "/zoxide" ];
      type = types.derivation;
      mutatorType = types.string;
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

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.fish;
      preWrap = ''
        rm -r $out/share/fish/vendor_completions.d $out/share/fish/vendor_functions.d
      '';
      symlinks = {
        "$out/share/fish/vendor_completions.d" = options.completions;
        "$out/share/fish/vendor_functions.d" = options.functions;
        "$out/share/fish/vendor_conf.d/config.fish" = options.interactiveShellInit;
      };
    };
}
