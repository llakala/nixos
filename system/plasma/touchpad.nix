{ hostVars, lib, ... }:
let
  touchpadName = hostVars.touchpadName or null;
in {
  # Some hosts won't have a touchpad, so they won't set this - so we gate behind
  # an `if`. We don't use the `input` module because it requires other metadata
  # about the touchpad that I don't want every host to have to provide.
  hm.programs.plasma.configFile.kcminputrc = lib.mkIf (touchpadName != null) {
    ${touchpadName} = {
      NaturalScroll = true;
      DisableWhileTyping = false;

      # Two-finger right click
      ClickMethod = 2;
    };
  };
}
