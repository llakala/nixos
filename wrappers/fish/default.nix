{ adios }:
let
  inherit (adios) types;
in {
  name = "fish";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.functions = {
    type = types.path;
    default = ./functions;
  };
  options.completions = {
    type = types.path;
    default = ./completions;
  };
  options.interactiveShellInitFile = {
    type = types.path;
    default = ./config.fish;
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
          ln -s ${options.interactiveShellInitFile} $out/share/fish/vendor_conf.d/config.fish
        '';
        meta.mainProgram = "fish";
      };
  };
}
