# If you're within the pager, exit it
# If not, cancel the current command and go to a new line (keeping the command
# in the scrollback)
function cancel-or-commandline
    if commandline --search-mode; or commandline --paging-mode
        commandline -f cancel
        return
    end
    commandline -f cancel-commandline
end
