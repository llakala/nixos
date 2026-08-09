{ vimPlugins, fetchFromGitHub, ... }:

# pointing to my fork with some indent changes and some startup logic removed
vimPlugins.vim-nix.overrideAttrs {
  src = fetchFromGitHub {
    owner = "llakala";
    repo = "vim-nix";
    rev = "b10d3b9894c5a46846bee13876e782f4885beb92";
    hash = "sha256-c5NlpQMjIjTi99/K+Ib4ohqrVLHYFNlcMsWZywoVYy0=";
  };
}
