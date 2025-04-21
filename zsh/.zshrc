# ---------------------
# Prompt
# ---------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.  
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
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

# Show command you typed in the command history
setopt HIST_IGNORE_SPACE       # Ignore commands that start with a space
setopt HIST_IGNORE_DUPS        # Don't store a command if it's the same as the previous one
# setopt HIST_IGNORE_ALL_DUPS    # Don't store any duplicate commands at all
setopt HIST_FIND_NO_DUPS       # Avoid showing duplicates when searching history
setopt HIST_EXPIRE_DUPS_FIRST  # Expire older duplicate entries first when trimming
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt HIST_VERIFY             # Don’t execute history lines immediately
# setopt SHARE_HISTORY           # Share history across all sessions
# setopt INC_APPEND_HISTORY      # Add commands to history immediately
setopt APPEND_HISTORY          # Append to history, don't overwrite

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
# Pyenv
# ---------------------

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
