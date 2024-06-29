# FEATURES:
- [ ] Change desktop hostname to work with new mkHosts setup
- [ ] Add disko configuration and reinstall everyone with it applied
- [ ] Create new aliases for rebuilding with option for fast install
- [ ] Try out KDE
- [ ] Add secrets management (either with sops or agenix)
- [ ] Try out impermanence


# SOFTWARE:
- [ ] Set up firefox dark mode + get google gone
- [ ] Kit out vscode with all options
    - [ ] Get vscode-server fully working
    - [ ] Work on vscode theme again (whether it's personal or lesbian theme)

- [ ] Kit out bash / try other terminals
- [x] Kit out firefox with all options

# IMPROVEMENTS:
- [ ] Make username consistent to avoid annoyance
- [ ] Create new, working iso with disko
- [ ] Add swap partition to disko
- [ ] Declare system per-host instead of globally
- [ ] See if hostVars can be enforced to have all the same variables
    - This could be done with mkIf and passing hostname from the flake.nix

- [x] Improve the way inputs are passed from flake to be more clear and less hacky (ASAP)
- [x] Learn how to custom-build firefox extensions to add movie-web remastered
    - OR: Make issue with rycee to add the extension

- [x] Move all non-base software to an area independent of host for modularity
    - [x] If this is implemented, make sure not to crowd flake.nix with imports
