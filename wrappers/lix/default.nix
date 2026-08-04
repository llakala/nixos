{ types, ... }:
{
  inputs = {
    nixpkgs.from = { parent }: parent.nixpkgs;
  };
  options = {
    settings = {
      type = types.attrs;
      default = {
        repl-overlays = ./repl-overlay.nix;
      };
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.lixPackageSets.latest.lix;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) runCommandLocal makeBinaryWrapper;
      inherit (inputs.nixpkgs.lib) concatStringsSep mapAttrsToList;
      flags =
        if !options ? settings then
          ""
        else
          concatStringsSep " " (
            mapAttrsToList (option: value: "--append-flags '--option ${option} ${value}'") options.settings
          );
    in
    # I need cppnix for perf testing, but want Lix for the repl-overlay, and
    # don't want their binaries conflicting. To solve this, we wrap the nix
    # binary from lix and puts it in $PATH as `lix`
    runCommandLocal "lix-wrapped"
      {
        nativeBuildInputs = [ makeBinaryWrapper ];
      }
      ''
        makeBinaryWrapper "${options.package}/bin/nix" "$out/bin/lix" --argv0 nix ${flags}
      '';
}
