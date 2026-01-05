
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
    };
    name = {
      type = types.string;
      defaultFunc = { options }: options.package.pname;
    };
    extraPaths = {
      type = types.listOf types.derivation;
      description = "Extra paths to be symlinked in the final derivation";
      default = [];
    };
    binaryPath = {
      type = types.string;
      defaultFunc = { options }: "$out/bin/${options.name}";
    };

    preWrap = {
      type = types.string;
      description = "Commands to be run before everything else in the postBuild phase";
      default = "";
    };
    postWrap = {
      type = types.string;
      description = "Commands to be run after everything else in the postBuild phase";
      default = "";
    };

    wrapperArgs = {
      type = types.string;
      description = "Extra args passed directly to wrapProgram";
      default = "";
    };
    environment = {
      type = types.attrsOf (types.union [
        types.string
        types.path
        types.derivation
        (types.typedef "null" isNull)
      ]);
      description = "Environment variables to be set during the execution of the wrapped program";
      default = {};
    };
    symlinks = {
      type = types.attrsOf (types.union [
        types.string
        types.derivation
        types.path
        (types.typedef "null" isNull)
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
      description = "Flags to be appended to the executed program.";
      default = [];
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) stdenvNoCC makeBinaryWrapper lndir;
      inherit (builtins) concatStringsSep attrValues mapAttrs filter;
      environmentStr = concatStringsSep " " (
        filter (x: x != null) (
          attrValues (
            mapAttrs (
              name: value:
              if value == null then null
              else "--set ${name} \"${value}\""
            ) options.environment
          )
        )
      );
      symlinkedStr = concatStringsSep "\n" (
        filter (x: x != null) (
          attrValues (
            mapAttrs (
              symlink: destination:
              if destination == null then null
              else "ln -s ${destination} ${symlink}"
            ) options.symlinks
          )
        )
      );
      flagsStr = concatStringsSep " " (
        map (flag: "--add-flag \"${flag}\"") options.flags
      );
    in
      stdenvNoCC.mkDerivation {
        name = "${options.name}-wrapped";
        buildInputs = [ makeBinaryWrapper ];
        paths = map (path: "${path}") (
          [ options.package ] ++ options.extraPaths
        );
        meta.mainProgram = options.name;
        passthru = options.package.passthru or {};

        preferLocalBuild = true;
        allowSubstitutes = false;
        enableParallelBuilding = true;
        passAsFile = [ "buildCommand" "paths" ];

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
