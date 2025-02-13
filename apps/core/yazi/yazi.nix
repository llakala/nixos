{ config, ... }:

{
  features.fileManager = "yazi"; # Change if we ever stop using Yazi

  hm.programs.yazi =
  {
    enable = true;
    shellWrapperName = "y";
  };

  # We can't use xdg-open for opening files with editor,
  # because it would start a new Kitty window
  # Instead, Yazi just uses $EDITOR, which is fine.
  # See the relevant issue for fixing that:
  # https://github.com/llakala/nixos/issues/74

  hm.programs.yazi.settings.manager =
  {
    sort_by = "extension";
    sort_dir_first = true;

  };
}
