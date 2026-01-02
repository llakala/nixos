let
  setCursor = expansion: {
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
  nrn = setCursor "nix run nixpkgs#%";
  "nr." = setCursor "nix run .#%";

  ns = "nix-shell";
  nsn = "nix-shell -p";

  "ns." = setCursor "nix shell .#%";

  nb = "nix-build";
  nba = "nix-build -A";
  nbn = "nix-build '<nixpkgs>' -A";

  "nb." = setCursor "nix build .#%";

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
