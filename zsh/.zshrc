# ---------------------
# Prompt
# ---------------------

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---------------------
# Basic Settings
# ---------------------

export SHELL=/bin/zsh
export EDITOR=vim  # Change to vim, nano, code, etc. as you like
export VISUAL=$EDITOR

# Allow comments in interactive shell
setopt INTERACTIVE_COMMENTS

# https://postgresqlstan.github.io/cli/zsh-history-options/
setopt EXTENDED_HISTORY        # Include timestamp
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt HIST_VERIFY             # Don’t execute history lines immediately (expand line without executing it)
setopt HIST_IGNORE_SPACE       # Ignore commands that start with a space

setopt HIST_IGNORE_DUPS        # Don't store a command if it's the same as the previous one
# setopt HIST_IGNORE_ALL_DUPS    # Don't store any duplicate commands at all
setopt HIST_EXPIRE_DUPS_FIRST  # Expire older duplicate entries first when trimming
setopt HIST_FIND_NO_DUPS       # Avoid showing duplicates when searching history

# APPEND_HISTORY without SHARE_HISTORY lets all shells immediately write to the history file,
# 	but other shells do not read those entries until they restart (or run `fc -R`)
# setopt SHARE_HISTORY           # Share history across all sessions (re-read continously from $HISTFILE)
setopt APPEND_HISTORY          # Append to history, don't overwrite
setopt INC_APPEND_HISTORY      # Append commands to history immediately

# History file config
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000


# ---------------------
# Alias
# ---------------------

if ls --color=auto > /dev/null 2>&1; then
    alias ls='ls --color=auto'
elif ls -G > /dev/null 2>&1; then
	    alias ls='ls -G'
fi

# ---------------------
# Completion
# ---------------------

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ---------------------
# Path Customization
# ---------------------

# Add custom bin folders to your PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# ---------------------
# fzf
# ---------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---------------------
# Pyenv
# ---------------------

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ---------------------
# Edit-Command-Line
# ---------------------

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line # type command in vim

# ---------------------
# Local Additions
# ---------------------

[ -f "$HOME/.zshrc_local" ] && source "$HOME/.zshrc_local"

