# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# export TERM=xterm-256color

# Set name of the theme to load --- if set to "random", it will load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="frontcube"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node npm gpg-agent tmux)
#source ~/.zsh/prompt.zsh
# source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH/oh-my-zsh.sh

# User configuration
bindkey -v
export VISUAL=nvim
export EDITOR="$VISUAL"
alias vim=nvim

# Aliases
source ~/.shell/aliases.sh

if [ -e $HOME/.dotfiles/vim/plugged/fzf/shell/key-bindings.zsh ]; then . $HOME/.dotfiles/vim/plugged/fzf/shell/key-bindings.zsh; fi

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

export PATH="${PATH}:${HOME}/.local/bin/"
if [ -e $HOME/.local/bin/flutter/bin/flutter ]; then export PATH="${PATH}:${HOME}/.local/bin/flutter/bin/"; fi
export PATH=~/.dotfiles/bin:${PATH}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # nvm 
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# nvm use default
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# alias -s exe=mono
export PATH="${PATH}:${HOME}/.local/bin/docfx"


# Load Angular CLI autocompletion.
source <(ng completion script)
