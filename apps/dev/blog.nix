{ pkgs, ... }:

let
  myRPackages = with pkgs.rPackages;
  [
    quarto
  ];

  # If we don't do it like this and add the r packages to
  # environment.systemPackages, then $PATH gets /nix/store paths, which
  # isn't recommended
  myR = pkgs.rWrapper.override {
    packages = myRPackages;
  };
in
{
  environment.systemPackages =
  [
    myR

    # You might also need to override rstudio to add custom R packages
    # I'm not doing that much R dev these days, but if you're here from
    # Github, try that
    pkgs.rstudio
  ];
}
