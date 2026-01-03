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
    };
    completions = {
      type = types.path;
    };
    abbreviations = {
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
          allAbbrs = concatLists (mapAttrsToList moduleToAbbrList mutators);
        in
        concatStringsSep "\n" allAbbrs;
    };

    interactiveShellInit = {
      type = types.string;
      mutatorType = types.string;
      mergeFunc =
        { mutators, options }:
        let
          inherit (builtins) attrValues concatStringsSep;
        in
          concatStringsSep "\n" (
            attrValues mutators ++ [ options.abbreviations ]
          );
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) fish writeText;
    in
    inputs.mkWrapper {
      package = fish;
      preWrap = ''
        rm -r $out/share/fish/vendor_completions.d $out/share/fish/vendor_functions.d
      '';
      symlinks = {
        "$out/share/fish/vendor_completions.d" = options.completions;
        "$out/share/fish/vendor_functions.d" = options.functions;
        "$out/share/fish/vendor_conf.d/config.fish" = writeText "config.fish" options.interactiveShellInit;
      };
    };
}
