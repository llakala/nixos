_: final: prev:
let
  inherit (builtins)
    all
    attrValues
    elemAt
    functionArgs
    getEnv
    getFlake
    isAttrs
    length
    pathExists
    ;
  optionalAttrs = cond: attrs: if cond then attrs else { };

  pwd = getEnv "PWD";
  hostname = getEnv "hostname";

  findFirst =
    pred: default: list:
    let
      len = length list;
      go =
        i:
        if i == len then
          default
        else if pred (elemAt list i) then
          elemAt list i
        else
          go (i + 1);
    in
    go 0;

  loadPath =
    path:
    let
      importedPath = import (pwd + "/${path}");
    in
    if isAttrs importedPath then importedPath else importedPath { };

  hasDefaultArgs =
    path:
    if isAttrs (import path) then
      true
    else
      all (val: val == true) (attrValues (functionArgs (import path)));

  isValidPath = path: pathExists (pwd + "/${path}") && hasDefaultArgs (pwd + "/${path}");
  firstValidPath = findFirst isValidPath null;
in
builtins
// {
  ${if isValidPath "default.nix" then "default" else null} = loadPath "default.nix";
  ${if isValidPath "wrappers.nix" then "wrappers" else null} = loadPath "wrappers.nix";
}
// (
  if baseNameOf pwd == "nixpkgs" then {
    pkgs = loadPath ".";
    lib = loadPath "lib";
  } else {
    pkgs = import <nixpkgs> { };
    lib = import <nixpkgs/lib>;
  }
)
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
// (
  let
    sourcesPath = firstValidPath [ "npins/default.nix" "other/npins/default.nix" ];
  in optionalAttrs (sourcesPath != null) {
    sources = loadPath sourcesPath;
  }
)
// (optionalAttrs (isValidPath "system.nix") {
  config = (loadPath "system.nix").${hostname}.config;
  options = (loadPath "system.nix").${hostname}.options;
})
