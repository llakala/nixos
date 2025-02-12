{ pkgs, lib, ... }:

{
  # referenced from:
  # https://github.com/sersorrel/sys/blob/392b14efb43a912ee49af4e6c5327329f2071d93/hm/starship.nix#L16
  # Theirs wasn't working for me, though (possibly a skill issue on my part)
  # I made `when` always be true, which may have fixed it
  hm.programs.starship.settings.custom.lorri =
  {
    description = "Whether lorri has finished evaluation yet";
    symbol = "";

    format = "[$symbol($output) ]($style)";
    command =
    # Returns either the completed, started, or failure symbol, depending on what keys[0] is
    /* bash */
    ''
      timeout 1 lorri internal stream-events --kind snapshot | ${lib.getExe pkgs.jq} -r --arg pwd "$PWD" 'if .[keys[0]].nix_file | startswith($pwd) then {Completed: "✓", Started: "⌛", Failure: "❌"}[keys[0]] else "" end'
    '';
    when = "true";
    shell = lib.singleton "sh";
  };
}
