# ==============================================================================
#  SYSTEM PATHS & ENV
# ==============================================================================
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export EDITOR="nano" # Change to nvim, vim, or code if preferred

# ==============================================================================
#  OLED BLACK THEME & LS_COLORS
# ==============================================================================
# Note: Ensure your Terminal Emulator background is set to true black (#000000).
# Recommended Font: JetBrains Mono Nerd Font, Fira Code NF, or Hack NF.

# Enable color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# OLED High-Contrast LS_COLORS (Vibrant Cyans, Magentas, and Greens look stunning on pitch black)
export LS_COLORS="di=01;36:ln=01;35:so=01;32:pi=40;33:ex=01;31:bd=40;34;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43"

# ==============================================================================
#  HISTORY CONFIGURATION
# ==============================================================================
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# History Options
setopt appendhistory       # Append to history file, don't overwrite
setopt sharehistory        # Share history across active sessions
setopt histignorealldups   # Ignore duplicate commands in history
setopt histignorespace     # Ignore commands starting with a space
setopt histverify          # Show command with expansion before running

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# ==============================================================================
#  MODERN COMPLETION SYSTEM (ZStyle)
# ==============================================================================
autoload -Uz compinit
compinit

# Enable menu selection (navigate completions with arrow keys)
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Case-insensitive and partial matching
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# Colorful completion list (matches our vibrant LS_COLORS)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''

# Descriptive completion messages
zstyle ':completion:*' verbose true
zstyle ':completion:*' format '%F{051}--- Completing %d ---%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' use-compctl false

# Kill command process completion styling
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ==============================================================================
#  CONVENIENT ALIASES
# ==============================================================================
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# ==============================================================================
#  PROMPT INITIALIZATION (Starship)
# ==============================================================================
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
else
    # Fallback OLED-friendly prompt if Starship is not active/installed
    PROMPT='%F{082}%n%f@%F{051}%m%f %F{201}%1~%f %# '
fi

# ==============================================================================
#  OPTIONAL: PLUGINS
# ==============================================================================
# Automatically source syntax highlighting & autosuggestions if installed via your distro
for plugin in /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
    [[ -f "$plugin" ]] && source "$plugin"
done


# ==============================================================================
#  AUTO-START TMUX
# ==============================================================================
# Only launch tmux if:
# 1. This is an interactive shell (prevents breaking scp/sftp)
# 2. We are NOT already inside a tmux session (prevents infinite recursion)
# 3. tmux is actually installed on the system
if [[ -n "$PS1" && -z "$TMUX" ]] && command -v tmux &> /dev/null; then
    exec tmux
fi
