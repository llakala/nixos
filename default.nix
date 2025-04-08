(import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
      inherit (lock.nodes.flake-compat.locked) narHash rev url;
    in
    builtins.fetchTarball {
      url = "${url}/archive/${rev}.tar.gz";
      sha256 = narHash;
    }
  )
  {
    src = ./.;
  }
).defaultNix
