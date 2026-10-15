{ self, ... }:

let
  inherit (builtins) concatStringsSep attrValues filter isFunction;
in {
  # Global registry just pins random flakes that eelco decided should be
  # first-class citizens for some reason
  nix.settings.flake-registry = "";

  # Keep nix registry synced with our pinned npins input
  nixpkgs.flake = {
    source = self.sources.nixpkgs;
    setNixPath = false;
    setFlakeRegistry = true;
  };

  # Keeps <nixpkgs> pinned to the current nixpkgs revision. Requires relog to
  # apply
  nix.nixPath = [
    "nixpkgs=${self.sources.nixpkgs.outPath}"
  ];

  # Add the npins sources to the runtime closure, so my daily gc doesn't remove
  # them and require a refetch
  environment.etc."npins-sources".text = concatStringsSep "\n" (
    filter (source: !isFunction source) (attrValues self.sources)
  );
}
