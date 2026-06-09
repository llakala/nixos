{ types, ... }:
{
  inputs = {
    nixpkgs.from = { parent }: parent.nixpkgs;
    self.from = { parent }: parent.self;
    kitty.from = { parent }: parent.kitty;
  };

  options = {
    desktopEntry = {
      type = types.derivation;
      defaultFunc = { inputs }: import ./desktopEntry.nix { inherit inputs; };
    };
    kittab = {
      type = types.derivation;
      defaultFunc = { inputs }: import ./kittab.nix { inherit inputs; };
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      kittyWrapper = inputs.kitty {};
    in
    pkgs.symlinkJoin {
      name = "kittab-wrapped";
      paths = [
        options.kittab
        options.desktopEntry
        kittyWrapper
      ];
      meta.mainProgram = "kittab";
    };
}
