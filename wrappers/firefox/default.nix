{ adios }:
let
  inherit (adios) types;
in {
  name = "firefox";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    # We make this a derivation, otherwise the path to the homedir would be
    # embedded in the autoconfig file. I'm okay with impurity sometimes, but it's
    # not necessary here
    userChromeFile = {
      type = types.derivation;
      defaultFunc =
        { inputs }:
        let
          inherit (inputs.nixpkgs) pkgs;
          inherit (pkgs) writeText;
          inherit (builtins) readFile;
        in
        writeText "userChrome.css" (readFile ./userChrome.css);
    };

    autoConfigFiles = {
      type = types.listOf types.derivation;
      defaultFunc =
        { inputs, options }:
        let
          inherit (inputs.nixpkgs) pkgs;
          inherit (pkgs) replaceVars;
        in
        [
          (replaceVars ./autoConfig.js { userChromeFile = options.userChromeFile; })
        ];
    };

    policiesFiles = {
      type = types.listOf types.path;
      default = [
        ./policies/extensions.json
        ./policies/policies.json
        ./policies/preferences.json
        ./policies/searchEngines.json
      ];
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
