{ config, ... }:

let
  scalingFactor = config.hostVars.fractionalScalingFactor;
in
{
  hm.programs.plasma.configFile = {
    # This one doesn't seem to be properly applying
    kwinrc.Xwayland.Scale = scalingFactor;
  };
}
