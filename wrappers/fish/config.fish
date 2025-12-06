status is-interactive || exit 0
set fish_greeting

set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore
set fish_cursor_visual      underscore blink

# This makes it so repeatedly pressing Ctrl+Z to suspend and unsuspend
# doesn't create a new line every time - which is wonderful. Thanks to
# krobelus on Matrix for the original snippet!
#
# Note - don't forget to check is_foreground! This prevents a
# frustrating issue where a multiline prompt would rerender incorrectly
# when triggering complete-or-search.
functions --copy fish_job_summary job_summary
function fish_job_summary -a job_id is_foreground cmd_line signal_or_end_name signal_desc proc_pid proc_name
    if [ "$signal_or_end_name" = STOPPED ]; and [ "$is_foreground" -eq 0 ]
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
