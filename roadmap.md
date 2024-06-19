# FEATURES:
- [ ] Add disko configuration and reinstall everyone with it applied
- [ ] Add secrets management (either with sops or agenix)
- [ ] Try out impermanence

- [ ] Try out KDE


# SOFTWARE:
- [ ] Kit out firefox with all options

- [ ] Kit out vscode with all options
    - [ ] Get vscode-server fully working
    - [ ] Work on vscode theme again (whether it's personal or lesbian theme)

- [ ] Kit out bash / try other terminals

# IMPROVEMENTS:
- [ ] Make username consistent to avoid annoyance


- [ ] Create new, working iso with disko
- [ ] Add swap partition to disko

- [ ] Move all non-base software to an area independent of host for modularity
    - [ ] If this is implemented, make sure not to crowd flake.nix with imports

- [ ] Declare system per-host instead of globally
- [ ] See if hostVars can be enforced to have all the same variables
    - This could be done with mkIf and passing hostname from the flake.nix
