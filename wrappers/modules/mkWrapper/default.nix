{ adios }:
let
  inherit (adios) types;
in {
  name = "mkWrapper";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    package = {
      type = types.derivation;
      description = "The package to be wrapped.";
    };
    name = {
      type = types.string;
      description = ''
        The name of the package to be wrapped.

        This determines the pname of the wrapped package, as well as the derivation to be automatically run when using `nix run`.
      '';
      defaultFunc = { options }: options.package.pname;
    };
    extraPaths = {
      type = types.listOf types.derivation;
      description = "Extra derivations which should have their directory structures replicated in the final package.";
      default = [];
    };
    binaryPath = {
      type = types.string;
      description = "Path within the input derivation to the binary which should be wrapped";
      defaultFunc = { options }: "$out/bin/${options.name}";
    };

    preWrap = {
      type = types.string;
      description = "Commands to be run before the wrapping process in the build steps.";
      default = "";
    };
    postWrap = {
      type = types.string;
      description = "Commands to be run after the wrapping process in the build steps.";
      default = "";
    };

    wrapperArgs = {
      type = types.string;
      description = "Extra args passed directly to wrapProgram.";
      default = "";
    };
    environment = {
      type = types.attrsOf (types.union [
        types.null
        types.pathLike
        (types.struct "readFromFileAtRuntime" {
          readFromFile = types.bool;
          value = types.pathLike;
        })
      ]);
      description = "Environment variables to be set during the execution of the wrapped program";
      default = {};
    };
    symlinks = {
      type = types.attrsOf (types.union [
        types.null
        types.pathLike
      ]);
      description = ''
        Symlinks to be included in the resulting derivation.
        Each key specifies the location within the derivation to create the symlink.
        Each value specifies where the symlink should be directed to.
      '';
      default = {};
    };
    flags = {
      type = types.listOf types.string;
      description = "Flags to be automatically appended to the wrapped program.";
      default = [];
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) stdenvNoCC callPackage lndir;
      inherit (builtins) attrNames concatMap concatStringsSep isAttrs;
      makeBinaryWrapper = callPackage ./makeBinaryWrapper/package.nix {};
      environmentStr = concatStringsSep " " (
        concatMap (
          var:
          let
            value = options.environment.${var};
          in
          if value == null then
            []
          else if isAttrs value && value ? readFromFile && value.readFromFile == true then
            [ "--set-from-file ${var} \"${value.value}\"" ]
          else
            [ "--set ${var} \"${value}\"" ]
        ) (attrNames options.environment)
      );
      symlinkedStr = concatStringsSep "\n" (
        concatMap (
          symlink:
          let
            destination = options.symlinks.${symlink};
          in
          if destination == null then []
          else [ "ln -s ${destination} ${symlink}" ]
        ) (attrNames options.symlinks)
      );
      flagsStr = concatStringsSep " " (
        map (flag: "--add-flag \"${flag}\"") options.flags
      );
    in
    stdenvNoCC.mkDerivation {
      name = "${options.name}-wrapped";
      buildInputs = [ makeBinaryWrapper ];
      paths = map (path: "${path}") ([ options.package ] ++ options.extraPaths);
      meta.mainProgram = options.name;
      passthru = options.package.passthru or {};

      preferLocalBuild = true;
      allowSubstitutes = false;
      enableParallelBuilding = true;
      passAsFile = [
        "buildCommand"
        "paths"
      ];

      buildCommand = ''
        mkdir -p $out
        for i in $(cat $pathsPath); do
          ${lndir}/bin/lndir -silent $i $out
        done
        ${options.preWrap}
        ${symlinkedStr}
        ${
          if environmentStr == "" && options.wrapperArgs == "" && options.flags == [] then
            ""
          else
            ''
              wrapProgram ${options.binaryPath} ${environmentStr} ${flagsStr} ${options.wrapperArgs}
            ''
        }
        ${options.postWrap}
      '';
    };
}
