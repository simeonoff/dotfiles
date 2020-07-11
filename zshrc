# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color

# Set name of the theme to load --- if set to "random", it will load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node npm npx gpg-agent tmux)
#source ~/.zsh/prompt.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
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
export PATH=~/.dotfiles/bin:${PATH}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
