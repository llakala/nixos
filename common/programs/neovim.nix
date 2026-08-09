{ self, ... }:

{
  environment.systemPackages = [ self.packages.neovim ];
  features.editor = "neovim"; # If we ever stop using Neovim, change this

  environment.variables.EDITOR = "nvim";

  # For when you want nvim as your manpager! I use bat by default for better
  # syntax highlighting, but I can use this when I want to follow local links
  # better.
  environment.shellAliases.vman = "MANPAGER='nvim +Man!' man";
}
