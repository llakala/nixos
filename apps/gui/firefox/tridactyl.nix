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

  hm.programs.firefox.policies.Preferences =
  {
    "browser.autofocus" = false;
  };


  hm.xdg.configFile."tridactyl/tridactylrc" =
  {
    text =
    /* java */
    ''
      " if we unset something, have it reset
      sanitise tridactyllocal tridactylsync

      set modeindicatorshowkeys true
      set hintnames short
      set tabopenpos last
      alias sort tabsort

      bind j scrollline 5
      bind k scrollline -5
      " tabs are more important than horizontal scrolling
      bind h tabprev
      bind l tabnext

      bind H back
      bind L forward
      bind J scrollpage +1
      bind K scrollpage -1

      bind a tab # " Last used tab

      " t for tab, silly
      bind t tabopen
      bind o fillcmdline open
      bind s fillcmdline tab

      bind q hint
      bind Q hint -b

      bind f hint -Jc a,button,input
      bind F hint -Jbc a,button,input


      unbind <<
      unbind >>
      bind < tabmove -1
      bind > tabmove +1

      " Follow promising-looking links to visit the likely next and previous pages of content.
      bind gh followpage prev
      bind gl followpage next

      unbind <C-f>
      unbind <C-a>

      " gi goes to github search
      bindurl ^https://github.com gi hint -Vc .AppHeader-searchButton
      " More relevant hints with github search
      bindurl ^https://github.com/search f hint -Jc .search-title a
      bindurl ^https://github.com/search F hint -Jbc .search-title a

      " While watching a video, unbind `f`, and give its duty to `q`
      unbindurl youtube.com/watch f
      unbindurl youtube.com/watch F
      bindurl youtube.com/watch q hint -Jc [class~=yt-simple-endpoint]
      bindurl youtube.com/watch Q hint -Jbc [class~=yt-simple-endpoint]

      " More relevant hints when selecting videos
      bindurl youtube.com$ f hint -Jc [class~=yt-simple-endpoint]
      bindurl youtube.com$ F hint -Jc [class~=yt-simple-endpoint]


      set searchurls.@gn https://github.com/search?type=code&q=lang:nix+NOT+is:fork+%s
      set searchurls.@gh https://github.com/search?type=code&q=NOT+is:fork+%s

      set searchurls.@ng https://noogle.dev/q?term=%s
      set searchurls.@npkgs https://github.com/search?type=code&q=repo:NixOS/nixpkgs+lang:nix+%s

      set searchurls.@oh https://home-manager-options.extranix.com/?release=release-24.11&query=%s
      set searchurls.@on https://search.nixos.org/options?channel=24.11&from=0&size=100&sort=alpha_asc&query=%s

      set searchurls.@hmgr https://github.com/search?type=code&q=repo:nix-community/home-manager+lang:nix+%s
    '';

    force = true;
  };
 }
