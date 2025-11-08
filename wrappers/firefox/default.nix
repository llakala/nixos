{ adios }:
let
  inherit (adios) types;
in
{
  name = "firefox";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.extraPreferences = {
    type = types.string;
    defaultFunc = { options }: import ./extraPreferences.nix { inherit (options) userChrome; };
  };
  options.extensions = {
    type = types.attrs;
    default = import ./extensions.nix;
  };
  options.policies = {
    type = types.attrs;
    default = import ./policies.nix;
  };
  options.preferences = {
    type = types.attrs;
    default = import ./preferences.nix;
  };
  options.searchEngines = {
    type = types.attrs;
    default = import ./searchEngines.nix;
  };
  options.userChrome = {
    type = types.path;
    default = ./userChrome.css;
  };
  options.ui = {
    type = types.string;
    default = builtins.readFile ./ui.json;
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) wrapFirefox;
      in
      wrapFirefox pkgs.firefox-unwrapped {
        extraPrefs = options.extraPreferences;
        extraPolicies = options.policies // {
          Preferences = options.preferences // {
            "browser.uiCustomization.state" = options.ui;
          };
          SearchEngines = options.searchEngines;
          ExtensionSettings = options.extensions;
        };
      };
  };
}
