# Move down in contexts like pager, history, and multiline expressions. if
# none of that is true, execute current command!
# Logic inspired from fish builtin function:
# https://github.com/fish-shell/fish-shell/blob/78e8f87e54d9d82c08cccd5cafc95126afe07274/share/functions/down-or-search.fish#L2
function down-or-execute
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
end
