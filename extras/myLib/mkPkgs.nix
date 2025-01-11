{ }: # So callPackage understands we have no file inputs

{ unpatchedInput, config, system, patches, ... }: # Function inputs
if patches == [] then
  import unpatchedInput # Skip the IFD if possible
  {
    inherit config system;
  }
else
  let
    unpatchedPkgs = unpatchedInput.legacyPackages.${system};

    patchedInput = unpatchedPkgs.applyPatches
    {
      name = "patchedInput";
      src = unpatchedInput;
      inherit patches;
    };

    pkgs = import patchedInput
    {
      inherit config;
      inherit system;
    };
  in
    pkgs