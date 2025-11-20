{ hostVars, lib, ... }:

let
  touchpadName = hostVars.touchpadName or null;
  mouseName = hostVars.mouseName or null;
in {
  hm.programs.plasma.configFile.kcminputrc = lib.mkMerge [
    # Matching the Gnome defaults I'm used to
    {
      Keyboard = {
        repeatDelay = 500;
        repeatRate = 30;
      };
    }

    # Each host provides either a touchpad or a mouse, and we declare the
    # correct settings based on which one they use.
    (lib.mkIf (touchpadName != null) {
      ${touchpadName} = {
        NaturalScroll = true;
        DisableWhileTyping = false;

        # Two-finger right click
        ClickMethod = 2;
      };
    })
    (lib.mkIf (touchpadName != null) {
      ${mouseName} = {
        # Disable mouse acceleration
        PointerAccelerationProfile = 1;

        PointerAcceleration = 0.0;
      };
    })
  ];
}
