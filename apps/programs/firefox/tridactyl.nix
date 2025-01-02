{ inputs, lib, pkgs, ... }:
let
  extensions = inputs.firefox-addons.packages.${pkgs.system};

  tridactyl = extensions.tridactyl;
in
{
  hm.programs.firefox =
  {
    profiles.default.extensions = lib.singleton tridactyl;
    nativeMessagingHosts = lib.singleton pkgs.tridactyl-native;
  };


  hm.xdg.configFile."tridactyl/tridactylrc" =
  {
    text =
    ''
      bind J tabnext
      bind K tabprev

      unbind <C-f>
    '';

    force = true;
  };
 }
