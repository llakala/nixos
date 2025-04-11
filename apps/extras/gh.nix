{ config, lib, pkgs, ... }:

let
  notBool = val: ! builtins.isBool val;

  # Having to write "enabled" and "disabled" is stupid
  boolsToYaml = lib.mapAttrs
  (
    _: val:
    if (notBool val) then val

    # Already true, so no need for ==
    else if val then "enabled"
    else "disabled"

  );
in
{
  hm.programs.gh =
  {
    enable = true;

    settings = boolsToYaml
    {
      editor = config.baseVars.editor;

      # TODO: make this use ssh when proper secrets are set up
      git_protocol = "https";
      prefer_editor_prompt = true;
    };

    extensions = with pkgs;
    [
      gh-dash
    ];
  };


}
