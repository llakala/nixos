{ config, ... }:

{

  environment.variables =
  {
    ABBR_SET_EXPANSION_CURSOR = 1; # Enable % syntax
  };

  hm.programs.zsh.zsh-abbr =
  {
    enable = true;
    abbreviations =
    {
      cdn = "cd ${config.baseVars.configDirectory}";

      n = "nix";
      nd = "nix develop";
      nr = "nix run";
      nrn = "nix run nixpkgs#%";
      nrp = "nix repl";
      nrpn = "nix repl nixpkgs";

      src = "source";

      g = "git";
      gst = "git status";
      glg = "git log";
      gan = "git add -AN"; # Add all untracked files

      gc = "git commit";
      gcm = "git commit -m \"%\"";

      gps = "git push";
      gpl = "git pull";

      gsw = "git switch";
      gswm = "git switch main";
      gswc = "git switch -c";

      grb = "git rebase";
      grbi = "git rebase -i HEAD~%"; # `grbi 2` will rebase from last 2 commits
      grbc = "git rebase --continue";

      gdf = "git diff HEAD"; # Including both unstaged and staged changes
      gdfs = "git diff --staged";
      gdfu = "git diff"; # Unstaged changes


      # Using our custom git aliases
      ghr = "git hire";
      gfr = "git fire";
      gkl = "git kill";

      gfs = "git force";

      grw = "git reword";
      grwm = "git reword --message"; # Get ready with me :3

      gam = "git amend";
    };
  };

  # Highlight our abbreviations for fast-syntax-highlighting. Code from https://zsh-abbr.olets.dev/advanced.html#fast-syntax-highlighting
  hm.programs.zsh.initExtra = # bash
  ''
    chroma_single_word()
    {
      (( next_word = 2 | 8192 ))

      local __first_call="$1" __wrd="$2" __start_pos="$3" __end_pos="$4"
      local __style

      (( __first_call )) && { __style=''${FAST_THEME_NAME}alias }
      [[ -n "$__style" ]] && (( __start=__start_pos-''${#PREBUFFER}, __end=__end_pos-''${#PREBUFFER}, __start >= 0 )) && reply+=("$__start $__end ''${FAST_HIGHLIGHT_STYLES[$__style]}")

      (( this_word = next_word ))
      _start_pos=$_end_pos

      return 0
    }

    register_single_word_chroma()
    {
      local word=$1
      if [[ -x $(command -v $word) ]] || [[ -n $FAST_HIGHLIGHT["chroma-$word"] ]]; then
        return 1
      fi

      FAST_HIGHLIGHT+=( "chroma-$word" chroma_single_word )
      return 0
    }

    if [[ -n $FAST_HIGHLIGHT ]]; then
      for abbr in ''${(f)"$(abbr list-abbreviations)"}; do
        if [[ $abbr != *' '* ]]; then
          register_single_word_chroma ''${(Q)abbr}
        fi
      done
    fi
  '';

}
