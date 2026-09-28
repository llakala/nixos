{ types, promise, ... }:
{
  inputs = {
    nixpkgs.from = { parent }: parent.nixpkgs;
    self.from = { parent }: parent.self;
    kitty.from = { parent }: parent.kitty;
  };

  options = {
    desktopEntry = {
      type = types.derivation;
      default = promise (import ./desktopEntry.nix);
    };
    kittab = {
      type = types.derivation;
      default = promise (import ./kittab.nix);
    };
  };

  result = promise (
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
    }
  );
}
