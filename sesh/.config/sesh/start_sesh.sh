#!/bin/bash

# This script is used to start the Sesh session.
tmux rename-window 'Neovim' && tmux send-keys 'vim' Enter
