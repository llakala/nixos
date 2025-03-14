{ pkgs, lib, config, ... }:

{
  # referenced from:
  # https://github.com/sersorrel/sys/blob/392b14efb43a912ee49af4e6c5327329f2071d93/hm/starship.nix#L16
  # Theirs wasn't working for me, though (possibly a skill issue on my part)
  # I made `when` always be true, which may have fixed it
  hm.programs.starship.settings.custom.lorri =
  assert config.features.direnv == "lorri";
  {
    description = "Whether lorri has finished evaluation yet";
    symbol = "";

    format = "[$symbol($output) ]($style)";
    command =
    # Returns either the completed, started, or failure symbol, depending on what keys[0] is
    # We don't show anything when we're not in a subdirectory of the lorri directory
    # The original logic only checked whether $pwd is in the key, but that gave false positives
    # when we were on a higher directory, like ~. Instead, we check whether the current directory
    # CONTAINS the directory of the lorri file. This will mean it won't activate for higher
    # directories, and will only activate for subdirectories.
    /* bash */
    ''
      timeout 2 lorri internal stream-events --kind snapshot | ${lib.getExe pkgs.jq} -r --arg pwd "$PWD" 'if .[keys[0]].nix_file | split("/") | del(.[-1]) | join("/") as $dir | $pwd | contains($dir) then {Completed: "✓", Started: "⌛", Failure: "❌"}[keys[0]] else "" end'
    '';
    when = "true";
    shell = lib.singleton "sh";
  };
}
