# ===== CORE SETTINGS ===== #
export EDITOR=nvim  # Default text editor
export HISTSIZE=10000  # Command history size
export SAVEHIST=10000  # Saved history
setopt INC_APPEND_HISTORY  # Write history after each command
setopt SHARE_HISTORY       # Share history across terminals

# ===== ALIASES ===== #
alias ll="ls -lah --color=auto"  # Better ls
alias nix-update="sudo nixos-rebuild switch"  # NixOS update
alias zshrc="nano ~/.zshrc && source ~/.zshrc"  # Quick edit & reload
# ===== PROMPT ===== #
autoload -U colors && colors  # Enable colors
PS1="%F{green}%n@%m %F{blue}%~ %F{red}%#%f "  # Simple prompt (user@host dir %)

bindkey '^I' autosuggest-accept  # Tab to accept suggestion
