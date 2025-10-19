{
  # Move down in contexts like pager, history, and multiline expressions. if
  # none of that is true, execute current command!
  # Logic inspired from fish builtin function:
  # https://github.com/fish-shell/fish-shell/blob/78e8f87e54d9d82c08cccd5cafc95126afe07274/share/functions/down-or-search.fish#L2
  hm.programs.fish.functions.down-or-execute = # fish
  ''
    if commandline --search-mode; or commandline --paging-mode
        commandline -f down-line
        return
    end
    set -l lnum (commandline -L)
    set -l line_count (count (commandline))

    if [ $lnum = $line_count ]
      commandline -f execute
    end

    commandline -f down-line
  '';

  # For setting keymap, use `fish_key_reader`
  # As of fish 4.0, this now uses more sane keybinding names - so update your
  # old binds to match the new style!
  hm.programs.fish.functions.fish_user_key_bindings = # fish
  ''
    fish_default_key_bindings

    bind tab complete-and-search
    bind ctrl-space complete-and-search

    bind ctrl-h backward-char
    bind ctrl-l forward-char
    bind ctrl-j down-or-execute # Custom function - see above
    bind ctrl-k up-line

    # Incentivise me to use ctrl+l for completions rather than arrow keys
    bind right forward-char-passive

    # Old Ctrl+C behavior, before 4.0
    bind ctrl-c cancel-commandline

    # Rerun previous command
    bind ctrl-s 'commandline $history[1]' 'commandline -f execute'

    bind ctrl-left backward-bigword
    bind ctrl-right forward-bigword
    bind shift-left backward-word
    bind shift-right forward-word
    bind --erase --preset alt-left
    bind --erase --preset alt-right
    bind ctrl-backspace backward-kill-bigword

    bind ctrl-m __fish_man_page
    bind --erase --preset alt-h
  '';
}
