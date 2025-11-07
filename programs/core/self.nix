{ self, config, ... }:

{
  # Custom packages from my flake, added to systemPackages for testing
  environment.systemPackages = with self.packages; [
    evalue
    emodule
    jc
    satod
  ];

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; { # Error if we ever change shell
    h = "satod hire";
    f = "satod fire";
    k = "satod kill";
  };
}
