{ lib, pkgs, self, ... }:

{
  hm.programs.bat = {
    enable = true;

    # List of command line options to supply every time
    config = {
      style = "plain";
      pager = lib.getExe self.wrappers.less.drv;
    };

    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
    ];
  };

  # Whenever instantiating a manpage, use bat! We don't need a shell alias or
  # `batman` - this serves the same thing.
  environment.variables = {
    MANPAGER = "sh -c 'col -bx | bat --language man'";
    MANROFFOPT = "-c";
  };

  # Waiting for https://github.com/nix-community/home-manager/issues/5481 to be fixed
  hm.home.activation.batCache = lib.mkForce "";
}
