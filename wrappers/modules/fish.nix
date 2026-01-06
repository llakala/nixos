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
    # TODO: add rfc42 variants of these
    completionsFiles = {
      type = types.listOf types.path;
    };
    functionsFiles = {
      type = types.listOf types.path;
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
          inherit (builtins) isString concatLists concatStringsSep replaceStrings;
          inherit (inputs.nixpkgs.lib) mapAttrsToList;
          # We use wrapping single quotes around our abbrs, so replace any
          # internal single quotes if they exist
          escapeSingleQuotes = str: replaceStrings [ "'" ] [ "\\'" ] str;
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
    # TODO: add rfc42 variant of this
    interactiveShellInit = {
      type = types.string;
      mutatorType = types.string;
      mergeFunc =
        { mutators, options }:
        let
          inherit (builtins) attrValues concatStringsSep;
        in
        concatStringsSep "\n" (
          [ "status is-interactive || exit 0" ]
          ++ attrValues mutators
          ++ [ options.abbreviations ]
        );
    };

    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.fish;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) writeText;
      inherit (builtins) listToAttrs;
    in
    inputs.mkWrapper {
      inherit (options) package;
      symlinks = {
        "$out/share/fish/vendor_conf.d/config.fish" = writeText "config.fish" options.interactiveShellInit;
      }
      // listToAttrs (
        map (path: {
          name = "$out/share/fish/vendor_completions.d/${baseNameOf path}";
          value = path;
        }) options.completionsFiles
      )
      // listToAttrs  (
        map (path: {
          name = "$out/share/fish/vendor_functions.d/${baseNameOf path}";
          value = path;
        }) options.functionsFiles
      );
    };
}
