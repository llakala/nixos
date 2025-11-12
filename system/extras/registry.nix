{ sources, ... }:

{
  # Global registry just pins random flakes that eelco decided should be
  # first-class citizens for some reason
  nix.settings.flake-registry = "";

  # Keep nix registry synced with our pinned npins input
  nixpkgs.flake = {
    source = sources.nixpkgs;
    setNixPath = false;
    setFlakeRegistry = true;
  };

  # Keeps <nixpkgs> pinned to the current nixpkgs revision. Requires relog to
  # apply
  nix.nixPath = [
    "nixpkgs=${sources.nixpkgs.outPath}"
  ];
}
