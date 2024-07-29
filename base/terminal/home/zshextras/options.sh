setopt AUTO_CD # If empty directory given as command, interpret it as cd
setopt INTERACTIVE_COMMENTS # Allow comments inside shells
setopt PIPEFAIL

export EDITOR=nano
export VISUAL="$EDITOR"

HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt APPEND_HISTORY # Add history to hist file automatically rather than waiting for shell to exit
setopt HIST_IGNORE_DUPS # Ignore duplicates only if they're right next to each other
setopt INC_APPEND_HISTORY_TIME # Share history between shells, but not when shells exist at the same time
setopt HIST_REDUCE_BLANKS