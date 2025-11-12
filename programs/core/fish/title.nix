{
  programs.fish.interactiveShellInit = # fish
  ''
    # Rewriting the fish_title function to print the full prompt_pwd. Sourced from:
    # https://github.com/fish-shell/fish-shell/blob/945a53/share/functions/fish_title.fish#L8
    function fish_title
      if set -q argv[1]
        echo -- (string sub -l 20 -- $argv[1]) (prompt_pwd -d0)

      else
        set -l command (status current-command)

        if [ $command = fish ]
          set command
        end

        echo -- (string sub -l 20 -- $command) (prompt_pwd -d0)
      end
    end
  '';
}
