let
  mkExtension = name: {
    install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${name}/latest.xpi";
    installation_mode = "force_installed";
  };
in {
  "*".installation_mode = "blocked";
  "uBlock0@raymondhill.net" = mkExtension "ublock-origin";
  "addon@darkreader.org" = mkExtension "darkreader";

  "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = mkExtension "return-youtube-dislikes";
  "sponsorBlocker@ajay.app" = mkExtension "sponsorblock";
  "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = mkExtension "refined-github-";
  "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = mkExtension "indie-wiki-buddy";

  "gdpr@cavi.au.dk" = mkExtension "consent-o-matic";
  "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack" = mkExtension "terms-of-service-didnt-read";

  "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = mkExtension "auto-tab-discard";
  "{6d85dea2-0fb4-4de3-9f8c-264bce9a2296}" = mkExtension "link-cleaner";
  "redirector@einaregilsson.com" = mkExtension "redirector";
}
