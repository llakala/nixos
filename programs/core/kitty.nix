{ pkgs, self, ... }:

{
  features.terminal = "kitty"; # Change if I ever stop using Kitty
  features.usingKittab = true; # For assertions, so we can rely on kittab's existence

  environment.systemPackages = [ self.wrappers.kittab.drv ];

  # We can't use the `shell_integration` output of our wrapper, since wrappers
  # don't preserve attributes like this
  hm.programs.fish.interactiveShellInit = ''
    source "${pkgs.kitty.shell_integration}/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "${pkgs.kitty.shell_integration}/fish/vendor_completions.d"
  '';
}
