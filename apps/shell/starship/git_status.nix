{ lib, ... }:

{
  hm.programs.starship.settings.git_status =
  {
    modified = "M";
    staged = "S";
    untracked = "A";
    renamed = "R";
    deleted = "D";
    conflicted = "U";
    stashed = "";

    ahead = "[+$count](green)";
    behind = "[-$count](red)";
    diverged = "[+$ahead_count](green),[-$behind_count](red)";

    style = "white";
    disabled = false;
  };

  # Referenced from https://github.com/clotodex/nix-config/blob/c878ff5d5ae674b49912387ea9253ce985cbd3cd/shell/starship.nix#L82
  hm.programs.starship.settings.git_status.format = lib.concatStrings
  [
    "[("

      "(\\["
        "[($conflicted)](orange)"
        "[($stashed)](white)"
        "[($staged)](blue)"
        "[($deleted)](red)"
        "[($renamed)](yellow)"
        "[($modified)](yellow)"
        "[($untracked)](green)"
      "\\])"

      "( \\[$ahead_behind\\])"

    " )]"
    "($style)"
  ];

}
