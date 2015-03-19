#!/bin/bash
#
# Start VIM in dark interface.
#

@echo off
#~/dotfiles/gnome-terminal-colors-solarized/set_dark.sh

# Change the background of the solarized theme in the .vimrc file to dark.
sed -i 's/set\sbackground=light/set background=dark/g' ~/dotfiles/.vimrc

echo "Dark VIM loaded."

vim $1
