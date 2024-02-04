# If you come from bash you might have to change your $PATH. export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# export TERM=xterm-256color

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
alias vim=nvim

# Aliases
source ~/.shell/aliases.sh

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

export PATH="${PATH}:${HOME}/.local/bin/"
if [ -e $HOME/.local/bin/flutter/bin/flutter ]; then export PATH="${PATH}:${HOME}/.local/bin/flutter/bin/"; fi

export PATH=~/.dotfiles/bin:${PATH}
export PATH=/usr/local/bin/docfx:${PATH}

# nvm use default
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Load the starship theme
eval "$(starship init zsh)"

# Add Pomodoro functions
work () {
  duration=$1
  timer "$duration" && terminal-notifier -message "Pomodoro"\
    -title "Work Timer is up! Take a Break 😊"\
    -appIcon "~/Pictures/tomato.png"\
    -sound Crystal
}

rest () {
  duration=$1
  timer "$duration" && terminal-notifier -message "Pomodoro"\
    -title "Break is over! Get back to work 😬"\
    -appIcon "~/Pictures/tomato.png"\
    -sound Crystal
}
