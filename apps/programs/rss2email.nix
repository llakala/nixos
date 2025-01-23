{ config, ... }:

{
  # Check config options with `nix shell nixpkgs#rss2email --command sh -c "man r2e"`
  # or just `man r2e` if it's already installed
  services.rss2email =
  {
    enable = true;

    interval = "weekly";
    to = config.baseVars.email;
  };

  # Many of these referenced from https://floss.social/@tomodachi94/112690423986002174
  # Plus some personal additions
  services.rss2email.feeds =
  {
    tvix.url = "https://tvl.fyi/feed.atom";
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

    # Non-Nix
    fish.url = "https://fishshell.com/blog/feed.xml";
    nushell.url = "https://www.nushell.sh/rss.xml";
  };
}