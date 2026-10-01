{ self, pkgs, ... }:

{
  environment.systemPackages = [
    self.wrappers.bat.result
    pkgs.bat-extras.batdiff
    pkgs.bat-extras.batgrep
  ];

  # Whenever instantiating a manpage, use bat! We don't need a shell alias or
  # `batman` - this serves the same thing.
  environment.variables = {
    MANPAGER = "sh -c 'col -bx | bat --language man'";
    MANROFFOPT = "-c";
  };
}
