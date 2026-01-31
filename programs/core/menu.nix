{ pkgs, self, ... }:

let
  menu = import "${self.sources.menu}/packages/default.nix" { inherit pkgs; };
in {
  environment.systemPackages = with menu; [
    fuiska
    imanpu
  ];

  # Overriding default values so we don't have to pass our arguments every time
  environment.variables = {
    UNIFY_DIRECTORY = self.hostVars.configDirectory; # Also used by fuiska
    IMANPU_DIRECTORY = "${self.hostVars.configDirectory}/various/npins";
  };
}
