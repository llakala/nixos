{ adios }:
{
  options = {
    policiesFiles.default = [
      ./policies/extensions.json
      ./policies/policies.json
      ./policies/preferences.json
      ./policies/searchEngines.json
    ];
    autoConfigFiles.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) replaceVars;
      in [
        (replaceVars ./autoConfig.js { userChromeFile = ./userChrome.css; })
      ];
  };
}

