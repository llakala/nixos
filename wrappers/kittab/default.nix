{ adios }:
let
  inherit (adios) types;
in
{
  name = "kittab";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    self.path = "/self";
    kitty.path = "/kitty";
  };

  options.desktopEntry = {
    type = types.derivation;
    defaultFunc =
      { inputs }:
      import ./desktopEntry.nix { inherit (inputs.nixpkgs) pkgs; };
  };

  options.kittab = {
    type = types.derivation;
    defaultFunc =
      { inputs }:
      import ./kittab.nix { inherit (inputs.self) myLib; };
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
      in
      pkgs.symlinkJoin {
        name = "kittab-wrapped";
        paths = [
          options.kittab
          options.desktopEntry
          inputs.kitty.drv
        ];
        meta.mainProgram = "kittab";
      };
  };
}
