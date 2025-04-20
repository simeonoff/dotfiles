# If you come from bash you might have to change your $PATH. export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
autoload -Uz compinit

# Set name of the theme to load --- if set to "random", it will load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node npm gpg-agent tmux)

source $ZSH/oh-my-zsh.sh

# User configuration
bindkey -v
export VISUAL=nvim
export EDITOR="$VISUAL"

# Aliases
source ~/.shell/aliases.sh
alias vim="env TERM=wezterm nvim --listen /tmp/nvim_instance_$(echo $$).sock"
alias cd="z"
alias python="python3"
alias path="copy-path"

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

export PATH="${PATH}:${HOME}/.local/bin/"
if [ -e $HOME/.local/bin/flutter/bin/flutter ]; then export PATH="${PATH}:${HOME}/.local/bin/flutter/bin/"; fi

export PATH=~/.dotfiles/bin:${PATH}

# Modifications for go lang with nix
# INFO: remove if not using go via nix
export GOROOT="/run/current-system/sw/bin"
export PATH=${PATH}:${HOME}/go/bin

# Modifications for nodejs with nix
export PATH=${PATH}:${HOME}/.npm-global/bin

# Change the config path for Lazygit
export XDG_CONFIG_HOME="$HOME/.config"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --pointer=" "
 --prompt="   "
 --color=fg:8,bg:-1,hl:2
 --color=fg+:-1,bg+:-1,hl+:4
 --color=info:8,prompt:2,pointer:2
 --color=marker:#87ff00,spinner:#af5fff,header:8'

# Load zoxide
eval "$(zoxide init zsh)"

# Load the starship theme
eval "$(starship init zsh)"

# Load direnv
eval "$(direnv hook zsh)"

# Add .NET Core SDK tools
export PATH="$PATH:/Users/SSimeonov/.dotnet/tools"
