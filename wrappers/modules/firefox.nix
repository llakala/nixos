{ adios }:
let
  inherit (adios) types;
in {
  name = "firefox";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    userChromeFile = {
      type = types.derivation;
    };
    autoConfigFiles = {
      type = types.listOf types.derivation;
    };
    policiesFiles = {
      type = types.listOf types.path;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) wrapFirefox writeText;
      inherit (builtins) readFile;
    in
    wrapFirefox pkgs.firefox-unwrapped {
      extraPrefsFiles = options.autoConfigFiles;
      extraPoliciesFiles = map
        (file: writeText "policies.json" (readFile file))
        options.policiesFiles;
    };
}
