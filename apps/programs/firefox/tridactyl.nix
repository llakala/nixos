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
      bind j scrollline 5
      bind k scrollline -5

      unbind <C-f>

      set searchurls.@gn https://github.com/search?type=code&q=lang:nix+NOT+is:fork+%s
      set searchurls.@gh https://github.com/search?type=code&q=NOT+is:fork+%s

      set searchurls.@ng https://noogle.dev/q?term=%s
      set searchurls.@npkgs https://github.com/search?type=code&q=repo:NixOS/nixpkgs+lang:nix+%s

      set searchurls.@oh https://home-manager-options.extranix.com/?release=release-24.11&query=%s
      set searchurls.@on https://search.nixos.org/options?channel=24.11&from=0&size=100&sort=alpha_asc&query=%s
    '';

    force = true;
  };
 }
