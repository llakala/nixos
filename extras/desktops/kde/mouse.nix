{ config, lib, ... }:
let
  mouseName = config.hostVars.mouseName;
in
{
  # Some hosts won't have a mousepad, so they won't set this - so we gate behind
  # an `if`.
  hm.programs.plasma.configFile.kcminputrc = lib.mkIf (mouseName != null)
  {
    ${mouseName} =
    {
      # Disable mouse acceleration
      PointerAccelerationProfile = 1;

      PointerAcceleration = 0.0;
    };
  };
}
