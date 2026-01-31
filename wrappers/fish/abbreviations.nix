let
  withCursor = expansion: {
    setCursor = true;
    inherit expansion;
  };
in
{
  m = "man";
  py = "python";
  j = "java";

  src = "source";

  npu = "npins update";
  ndr = "nix-direnv-reload";
}
// {
  nd = "nix develop";
  ne = "nix eval";
  nfu = "nix flake update";
  nfl = "nix flake lock";

  nr = "nix run";
  nrn = withCursor "nix run nixpkgs#%";
  "nr." = withCursor "nix run .#%";

  ns = "nix-shell";
  nsn = {
    setCursor = true;
    expansion = "nix-shell -p % --command fish";
  };

  "ns." = withCursor "nix shell .#%";

  nb = "nix-build";
  nba = "nix-build -A";
  nbn = "nix-build '<nixpkgs>' -A";

  "nb." = withCursor "nix build .#%";

  nrp = "nix repl";
  nrpn = "nix repl nixpkgs";
  nrpf = "nixos-rebuild repl";
}
// {
  h = "satod hire";
  f = "satod fire";
  k = "satod kill";

  v = "nvim";

  fsk = "fuiska";
  imp = "imanpu";
}
