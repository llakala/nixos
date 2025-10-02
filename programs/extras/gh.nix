{ lib, config, ... }:

let
  notBool = val: ! builtins.isBool val;

  # Having to write "enabled" and "disabled" is stupid
  boolsToYaml = lib.mapAttrs (
    _: val:
    if (notBool val) then val
    else if val then "enabled" # Already true, so no need for ==
    else "disabled"
  );
in {
  hm.programs.gh = {
    enable = true;

    settings = boolsToYaml {
      editor =
        assert config.features.editor == "neovim";
        "nvim";

      git_protocol = "https"; # TODO: make this use ssh when proper secrets are set up
      prefer_editor_prompt = true;
    };
  };
}
