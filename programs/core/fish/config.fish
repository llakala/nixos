set fish_greeting

set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore
set fish_cursor_visual      underscore blink

# Ctrl+Z to resume
# Don't ask me how this works, I have no clue! But it means repeatedly
# pressing Ctrl+Z to suspend and unsuspend doesn't create a new line every
# time - which is wonderful. Thanks to krobelus on Matrix for the snippet!
#
# Also note that this does leave the first part of the command in your title
# when running multiple times - but that's a Fish bug I've had forever, and
# I'll accept it if it means we don't have to deal with constant repaints.
bind \cz 'fg 2>/dev/null'
functions --copy fish_job_summary job_summary
function fish_job_summary
    if contains STOPPED $argv
        return
    end
    job_summary $argv
end


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


fish_default_key_bindings

bind tab complete-and-search
bind ctrl-space complete-and-search

bind ctrl-h backward-char
bind ctrl-l forward-char
bind ctrl-j down-or-execute # Custom function
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
