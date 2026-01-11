{ adios }:
let
  inherit (adios) types;
in {
  name = "firefox";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    autoConfigFiles = {
      type = types.listOf types.pathLike;
      description = ''
        `autoconfig.js` files to be injected into the wrapped package.

        See the Firefox documentation:
        https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig
      '';
    };

    policies = {
      type = types.attrs;
      description = ''
        Policies to be injected into the wrapped package.

        `policies.Preferences` can be used to inject preferences.

        Disjoint with the `policiesFiles` option.
      '';
    };
    policiesFiles = {
      type = types.listOf types.pathLike;
      description = ''
        JSON files containing policies to be injected into the wrapped package.

        To inject preferences, code like this can be used:
        ```json
        {
          "policies": {
            "Preferences": {
              "YOUR_PREFERENCES": "here"
            }
          }
        }
        ```

        See the Firefox documentation:
        https://support.mozilla.org/en-US/kb/customizing-firefox-using-policiesjson

        Disjoint with the `policies` option.
      '';
    };

    package = {
      type = types.derivation;
      description = ''
        The Firefox package to be wrapped.
        Note that this should use a `-unwrapped` variant.
        '';
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.firefox-unwrapped;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) wrapFirefox;
      inherit (builtins) filter attrNames;
      filterNullAttrs = set: removeAttrs set (filter (name: isNull set.${name}) (attrNames set));
    in
    assert !(options ? policies && options ? policiesFiles);
    wrapFirefox options.package (filterNullAttrs {
      extraPrefsFiles = options.autoConfigFiles or null;
      extraPolicies = options.policies or null;
      # From my testing, these need to be coerced to store paths.
      # If you know of a workaround to allow impure paths to be used here,
      # please make a PR!
      extraPoliciesFiles =
        if options ? policiesFiles then
          map (file: "${file}") options.policiesFiles
        else
          null;
    });
}
