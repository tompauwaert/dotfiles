#!/bin/bash

# Remove everything in active_environment and reset to dummy_links
# and restore the link to the general plugin folder.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
rm -rf "${DIR}/active_environment"
mkdir "${DIR}/active_environment"
ln -s "${DIR}/dummy_environment/local.vim" "${DIR}/active_environment/local.vim"
ln -s "${DIR}/dummy_environment/local.bash" "${DIR}/active_environment/local.bash"
ln -s "${DIR}/general/plugin/" ~/.vim
