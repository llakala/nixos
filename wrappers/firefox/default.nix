{ adios }:
let
  inherit (adios) types;
in
{
  name = "firefox";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.preferencesFiles = {
    type = types.listOf (types.union [
      types.derivation
      types.path
    ]);
    defaultFunc = { inputs }: let
      inherit (inputs.nixpkgs) pkgs;
    in [
      ./preferences.json
      (pkgs.replaceVars ./autoConfig.js { userChromeFile = ./userChrome.css; })
    ];
  };

  options.policiesFiles = {
    type = types.listOf types.path;
    default = [
      ./extensions.json
      ./policies.json
      ./searchEngines.json
      ./ui.json
    ];
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) wrapFirefox writeText;
        inherit (builtins) isPath;
      in
      wrapFirefox pkgs.firefox-unwrapped {
        extraPrefsFiles = map (file:
          if isPath file then
            writeText "preferences.json" (builtins.readFile file)
          else file
        ) options.preferencesFiles;
        extraPoliciesFiles = map (file:
          writeText "policies.json" (builtins.readFile file)
        ) options.policiesFiles;
      };
  };
}
