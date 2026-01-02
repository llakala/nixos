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
      type = types.path;
    };
    autoConfigFiles = {
      type = types.listOf types.path;
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
      # TODO: remove map here
      extraPoliciesFiles = map
        (file: writeText "policies.json" (readFile file))
        options.policiesFiles;
    };
}
