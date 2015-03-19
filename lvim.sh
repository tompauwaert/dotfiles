#!/bin/bash
#
# Start VIM in dark interface.
#

@echo off
#~/dotfiles/gnome-terminal-colors-solarized/set_light.sh

# Change the background of the solarized theme in the .vimrc file to dark.
sed -i 's/set\sbackground=dark/set background=light/g' ~/dotfiles/.vimrc

echo "Light VIM loaded."

vim $1
