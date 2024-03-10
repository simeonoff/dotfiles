# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:$HOME/.dotfiles/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH:$HOME/.dotfiles/bin"
fi
export PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
. "$HOME/.cargo/env"
