function fish_user_key_bindings
    bind tab complete-and-search
    bind ctrl-space complete-and-search

    bind ctrl-h backward-char
    bind ctrl-l forward-char
    bind ctrl-j down-or-execute # Custom function
    bind ctrl-k up-line

    # Incentivise me to use ctrl+l for completions rather than arrow keys
    bind right forward-char-passive

    # Custom command so ctrl-c exits the pager if you're within it, and cancels the
    # current command anywhere else
    bind ctrl-c cancel-or-commandline

    # Rerun previous command
    bind ctrl-s 'commandline $history[1]' 'commandline -f execute'

    bind \cz 'fg 2>/dev/null'

    bind ctrl-left backward-bigword
    bind ctrl-right forward-bigword
    bind alt-left backward-word
    bind alt-right forward-word
    bind --erase --preset shift-left
    bind --erase --preset shift-right
    bind ctrl-backspace backward-kill-bigword
    bind alt-backspace backward-kill-word

    bind ctrl-m __fish_man_page
    bind --erase --preset alt-h
end
