# ==========================================================
# 0. Early setup: environment basics
# ==========================================================

export SHELL=/bin/zsh
export EDITOR=vim
export VISUAL=$EDITOR

# Platform detection (used later)
case "$OSTYPE" in
  darwin*)  platform="macOS" ;;
  linux*)   platform="Linux" ;;
  msys*|cygwin*|win*) platform="Windows" ;;
  *)        platform="Unknown" ;;
esac

# ==========================================================
# 1. Path configuration
# ==========================================================

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# ==========================================================
# 2. Prompt and plugin loading
# ==========================================================

# --- Pure prompt ---
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# --- Plugin loading (order matters!) ---
# Load autosuggestions before syntax highlighting
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==========================================================
# 3. History configuration
# ==========================================================

setopt INTERACTIVE_COMMENTS    # Allow comments in interactive shell
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

# ===============================
# Aliases
# ===============================

if [[ "$platform" == "macOS" ]]; then
  alias ll='ls -halG'
elif [[ "$platform" == "Linux" ]]; then
  alias ll='ls -hal --color=auto'
fi

# ==========================================================
# 5. Completion system
# ==========================================================

autoload -Uz compinit
# Use a compiled completion dump for speed (cache)
if [[ -n ~/.zcompdump ]]; then
  compinit -C
else
  compinit
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ==========================================================
# 6. Integrations (fzf, pyenv, etc.)
# ==========================================================

# --- fzf integration ---
# Should come after compinit and plugin loading
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Pyenv ---
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# # ==========================================================
# # 7. Edit Command Line
# # ==========================================================

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line  # Ctrl+X Ctrl+E → edit current command

# ===============================
# 8. Keybindings (universal)
# ===============================

# Use emacs-style keybindings (required if $EDITOR=vim or $VISUAL=vim)
bindkey -e

# ==========================================================
# 9. Local overrides (optional)
# ==========================================================

# For machine-specific or private config
if [[ -f "${HOME}/.zshrc_local" ]]; then
  source "${HOME}/.zshrc_local"
fi
