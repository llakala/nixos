# FEATURES:
- [ ] Move all of this to github issues
- [ ] Move to home-manager standalone for more stability

- [ ] Package firefox without wayland
- [ ] Add xdg-mime full setup

- [ ] Set up SSH
- [ ] Try out KDE

- [ ] Add secrets management (either with sops or agenix)
- [ ] Try out impermanence

- [ ] Bring disko back (NOT YET)

- [x] GET LANDO WORKING!!!
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

- [ ] Make lando actually go to path rather than with a stupid alias

- [ ] Watch vimjoyer on shell scripts
    - [ ] Then make shell script for lando
    - [ ] Then, make shell script for install with home-manager and chown

- [ ] Watch vimjoyer on shell
    - [ ] Write something basic there for practice

- [ ] Ask discord if there's a way to pass the set from flake.nix to mkHosts.nix so that the functions are more lightweight

- [ ] Reinstall desktop name with name and host as "emanresu@desktop"

- [ ] Add swap partition to disko

- [ ] See if hostVars can be enforced to have all the same variables
    - This could be done with mkIf and passing hostname from the flake.nix

- [x] Fix broken link to roadmap in readme
- [x] Fix clipboard indicator (it fixed itself on reinstall)
- [x] Make vscode.dev consistently redirect to vscode using handlers
- [x] Obtain pre-existing nix index database from https://github.com/Mic92/nix-index-database
- [x] Create new, working iso with disko
- [x] Improve the way inputs are passed from flake to be more clear and less hacky (ASAP)
- [x] Learn how to custom-build firefox extensions to add movie-web remastered
    - OR: Make issue with rycee to add the extension

- [x] Move all non-base software to an area independent of host for modularity
    - [x] If this is implemented, make sure not to crowd flake.nix with imports

- [x] Update readme to reflect not using base anymore