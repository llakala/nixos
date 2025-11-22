{ adios }:
let
  inherit (adios) types;
in {
  name = "ripgrep";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.flags = {
    type = types.string;
    defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./ripgreprc;
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) symlinkJoin makeWrapper;
      in
      symlinkJoin {
        name = "ripgrep-wrapped";
        paths = [ pkgs.ripgrep ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          wrapProgram $out/bin/rg \
            --add-flags "${options.flags}" \
        '';
        meta.mainProgram = "rg";
      };
  };
}
