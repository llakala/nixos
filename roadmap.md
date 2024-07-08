# FEATURES:

- [ ] Package firefox without wayland
- [ ] Add xdg-mime full setup

- [ ] Set up SSH
- [ ] Try out KDE

- [ ] Add secrets management (either with sops or agenix)
- [ ] Try out impermanence

- [x] Create new aliases for rebuilding with option for fast install
- [x] Add disko configuration and reinstall everyone with it applied


# SOFTWARE:
- [ ] Set up firefox dark mode
- [ ] Make firefox scroll slower
- [ ] Kit out vscode with all options
    - [ ] Get vscode-server fully working

- [ ] Work on vscode theme again (whether it's personal or lesbian theme)
    - [ ] Get npm packages like watch working correctly


- [ ] Kit out bash / try other terminals
- [x] Kit out firefox with all options


# IMPROVEMENTS:

- [ ] Create shell script that initializes home-manager and makes user own /etc/nixos
- [ ] Use movie-web from rycee's

- [ ] Ask discord if there's a way to pass the set from flake.nix to mkHosts.nix so that the functions are more lightweight

- [ ] Reinstall desktop name with name and host as "emanresu@desktop"

- [ ] Add swap partition to disko

- [ ] See if hostVars can be enforced to have all the same variables
    - This could be done with mkIf and passing hostname from the flake.nix

- [x] Create new, working iso with disko
- [x] Improve the way inputs are passed from flake to be more clear and less hacky (ASAP)
- [x] Learn how to custom-build firefox extensions to add movie-web remastered
    - OR: Make issue with rycee to add the extension

- [x] Move all non-base software to an area independent of host for modularity
    - [x] If this is implemented, make sure not to crowd flake.nix with imports

- [x] Update readme to reflect not using base anymore