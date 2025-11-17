_: final: prev:
let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;

  inherit (builtins) pathExists all functionArgs attrValues isAttrs getFlake getEnv;
  inherit (lib) optionalAttrs findFirst;

  pwd = getEnv "PWD";

  loadPath = path: let
    importedPath = import "${pwd}/${path}";
  in
    if isAttrs importedPath then importedPath else importedPath {};

  hasDefaultArgs =
    path:
    if isAttrs (import path) then
      true
    else
      all (val: val == true) (attrValues (functionArgs (import path)));

  isValidPath = path: pathExists "${pwd}/${path}" && hasDefaultArgs "${pwd}/${path}";
  firstValidPath = paths: findFirst isValidPath null paths;
in {
  inherit pkgs lib;
}
// (
  let
    packagesPath = firstValidPath [ "packages/default.nix" "packages.nix" ];
  in optionalAttrs (packagesPath != null) {
    packages = loadPath packagesPath;
  }
)
// (optionalAttrs (isValidPath "flake.nix") rec {
  flake = getFlake pwd;
  inherit (flake) outputs;
})
// (optionalAttrs (isValidPath "default.nix") {
  default = loadPath "default.nix";
})
// (optionalAttrs (isValidPath "wrappers/default.nix") {
  wrappers = loadPath "wrappers/default.nix";
})
// (
  let
    sourcesPath = firstValidPath [ "npins/default.nix" "various/npins/default.nix" ];
  in optionalAttrs (sourcesPath != null) {
    sources = loadPath sourcesPath;
  }
)
