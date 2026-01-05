
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
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.lib) foldlAttrs;
      inherit (inputs.nixpkgs.pkgs) stdenvNoCC makeWrapper lndir;
      environmentStr = foldlAttrs (
        acc: name: value:
        if value == null then
          acc
        else if acc == "" then
          acc + "--set ${name} \"${value}\""
        else
          acc + " --set ${name} \"${value}\""
      ) "" options.environment;
      symlinkedStr = foldlAttrs (
        acc: symlink: destination:
        if destination == null then
          acc
        else if acc == "" then
          acc + "ln -s ${destination} ${symlink}"
        else
          acc + "\nln -s ${destination} ${symlink}"
      ) "" options.symlinks;
    in
      stdenvNoCC.mkDerivation {
        name = "${options.name}-wrapped";
        buildInputs = [ makeWrapper ];
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
            if environmentStr == "" && options.wrapperArgs == "" then
              ""
            else
            ''
              wrapProgram ${options.binaryPath} ${environmentStr} ${options.wrapperArgs}
            ''
          }
          ${options.postWrap}
        '';
      };
}
