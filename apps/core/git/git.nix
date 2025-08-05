{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    difftastic
    meld
    tig
    diff-so-fancy
  ];
}
