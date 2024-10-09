# Run `cat` to see what a certain shortcut corresponds to
bindkey '^I' autosuggest-accept # Tab

bindkey "^[[1;5C" forward-word # Ctrl + Left-Arrow
bindkey "^[[1;5D" backward-word # Ctrl + Right-Arrow
bindkey "^[[1;5A" beginning-of-line # Ctrl + Up-Arrow
bindkey "^[[1;5B" end-of-line # Ctrl + Down-Arrow

bindkey '^H' backward-delete-word # Ctrl + Backspace

bindkey '^[[Z' undo # Shift+tab undo last action
bindkey '^Z' undo # Ctrl+Z undo last action

bindkey -r '^[e' # Bind Alt+E to nothing so we can use it within Helix
