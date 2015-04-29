#!/bin/bash

# Remove everything in active_environment, reset
# and restore the link to the general plugin folder.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
rm -rf "${DIR}/active_environment"
mkdir -p "${DIR}/active_environment"
echo 'general' > vimenv/active_environment/current.env
rm ~/.vim
ln -s "${DIR}/general/plugin/" ~/.vim
