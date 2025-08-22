{ baseVars, lib, pkgs, ... }:

{
  # Package seems to be required, yet not added to derivation. Something
  # to look into.
  environment.systemPackages = lib.singleton pkgs.system-sendmail;

  # Check config options with:
  # `nix shell nixpkgs#rss2email --command sh -c "man r2e"`
  # or just `man r2e` if it's already installed
  # Check that it's functioning with:
  # `systemctl status rss2email`
  # And:
  # `systemctl status rss2email.timer`
  #
  # Note that this isn't actually functioning yet - I don't get any errors,
  # but it just doesn't seem to ever email me.
  services.rss2email = {
    enable = true;

    # Follows systemd time format, see `man systemd.time` for examples
    interval = "1d";
    # interval = "1m"; # For testing

    to = baseVars.email;

    # Pretty sure this might be a soft requirement for things to function
    config.from = "test@example.org";
  };

  # Many of these referenced from https://floss.social/@tomodachi94/112690423986002174
  # Plus some personal additions
  services.rss2email.feeds = {
    lix.url = "https://lix.systems/blog/index.xml";
    determinate.url = "https://determinate.systems/rss.xml"; # Determinate is a plague on Nix, but I'd still like to know what they're doing
    clan.url = "https://docs.clan.lol/feed_rss_created.xml";

    ayats.url = "https://ayats.org/feed.xml";
    tiserbox.url = "https://blog.tiserbox.com//atom.xml";
    jade.url = "https://jade.fyi/rss.xml";
    cafkafk.url = "https://cafkafk.dev/index.xml";
    tomodachi94.url = "https://tomodachi94.github.io/blog/index.xml";
    trofi.url = "https://trofi.github.io/feed/rss.xml";
    samuel-dionne-riel.url = "https://samuel.dionne-riel.com/blog/index.xml";
    myme.url = "https://myme.no/atom-feed.xml";
    bmcgee.url = "https://bmcgee.ie/posts/index.xml";
    vtimofeenko.url = "https://vtimofeenko.com/index.xml";
    oddlama.url = "https://oddlama.org/rss.xml";
    isabelroses.url = "https://isabelroses.com/feed.xml";

    # For testing - an rss feed that updates every 30 seconds.
    # aaaaaaa.url = "https://lorem-rss.herokuapp.com/feed?unit=second&?interval=30";

    # Non-Nix
    fish.url = "https://fishshell.com/blog/feed.xml";
    nushell.url = "https://www.nushell.sh/rss.xml";
    axlefublr.url = "https://axlefublr.github.io/rss.xml";
  };
}
