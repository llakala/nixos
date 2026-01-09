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
    # TODO: add mergeFunc for completions and functions options
    completions = {
      type = types.attrsOf types.string;
    };
    completionsFiles = {
      type = types.listOf types.pathLike;
      mutatorType = types.listOf types.pathLike;
      mergeFunc = adios.lib.mergeFuncs.concatLists;
    };

    functions = {
      type = types.attrsOf types.string;
    };
    functionsFiles = {
      type = types.listOf types.pathLike;
      mutatorType = types.listOf types.pathLike;
      mergeFunc = adios.lib.mergeFuncs.concatLists;
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

    # TODO: add impure variant of this
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
      inherit (builtins) listToAttrs attrNames;
    in
    assert !(options ? completions && options ? completionsFiles);
    assert !(options ? functions && options ? functionsFiles);
    inputs.mkWrapper {
      inherit (options) package;
      symlinks = {
        "$out/share/fish/vendor_conf.d/config.fish" = writeText "config.fish" options.interactiveShellInit;
      }
      // (
        if options ? completionsFiles then
          listToAttrs (
            map (path: {
              name = "$out/share/fish/vendor_completions.d/${baseNameOf path}";
              value = path;
            }) options.completionsFiles
          )
        else if options ? completions then
          listToAttrs (
            map (path: {
              name = "$out/share/fish/vendor_completions.d/${path}.fish";
              value = writeText path options.completions.${path};
            }) (attrNames options.completions)
          )
        else
          {}
      )
      // (
        if options ? functionsFiles then
          listToAttrs (
            map (path: {
              name = "$out/share/fish/vendor_functions.d/${baseNameOf path}";
              value = path;
            }) options.functionsFiles
          )
        else if options ? functions then
          listToAttrs (
            map (path: {
              name = "$out/share/fish/vendor_functions.d/${path}.fish";
              value = writeText path options.functions.${path};
            }) (attrNames options.functions)
          )
        else
          {}
      );
    };
}
