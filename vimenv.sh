#!/bin/bash

# -----------------------------------------------------------------
# | Introduction
# -----------------------------------------------------------------
# This script allows the user to switch between different VIM development 
# environments.Currently only two levels of 'configurations' will be supported.
# That is, there is a general configuration, which is always loaded and will 
# contain those plugins and settings common to tall tasks. The second level is 
# the configuration that is specific to a certain language or development 
# environment. E.g. python or android development.
# 
# -----------------------------------------------------------------
# | Supported commands
# -----------------------------------------------------------------
# 
# VimEnv supports a few commands:
# - Just using 'vimenv' will tell you the currently active environment
# - 'vimenv $environment_name' will switch to the named environment, if it 
# exists. Ifthe specified environment does not exist, this script will change 
# nothing.
# 
# -----------------------------------------------------------------
# | How the script works:
# -----------------------------------------------------------------
# 
# This script relies heavily on symbolic linking. In general the '~/.vimrc' file
# will be linked to the 'local.vim' file in the 'general' environment. And the 
# plugin folder '~/.vim/' will be linked to the pluging folder in the general 
# environment.
# 
# Your 'local.vim' file in the 'general' environment should contain all your 
# shared settings and contain the following lines at the bottom of the 
# 'local.vim' file:
# 
# let $LOCALFILE=expand("~/dotfiles/vimenv/active_environment/local.vim")
# if filereadable($LOCALFILE)
     #source $LOCALFILE
# endif
# 
# Any environment activated - other than the general environment will cause that
# environments files to be symlinked into the 'active_environment' folder. This 
# means the following links will be created in the 'active_environment' folder 
# (example for a python environment):
# - 'active_environment/local.vim' -> linked to 'python/local.vim'
# - 'active_environment/bash.vim' -> linked to 'python/bash.vim'
# - 'active_environment/plugin/' -> linked to 'python/plugin/'
# 
# This means that when VIM loads the 'general/local.vim' file, it will source
# the 'active_environment/local.vim' file, which in this case is linked to the 
# python configuration: 'python/local.vim'. And thus the python specific
# settings will be loaded for that environment.
#
# For the plugins, a similar method is used. This script relies on the user
# using Vundle  for plugin management. To make sure that any plugins the user
# adds to the specific 'local.vim' from an environment are correctly installed
# into the folder of that environment we use a different method of symlinking.
# In active_environment we make following links (again with python as example):
# - 'active_environment/plugin/' -> linked to 'python/plugin/'
# - All plugins in 'general/plugin/' are then symlinked into the
# 'active_environment/plugin/' folder, these symlinks are removed from the
# plugin folder before switching to another environment.
#
# To add any plugins to the general environment, make the required changes to
# the 'local.vim' file of the general configuration, then switch to the general
# environment. Then upon starting VIM, use the :PluginInstall implemented by
# Vundle. All plugins will now be installed in the 'general/plugin/' folder.
#

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

while [[ $# > 0 ]]
do
    key="$1"

    case $key in
        -r|--reset)
            RESET=true
            ;;
        --r|-reset)
            echo "Valid reset options are: -r | --reset"
            exit 1
            ;;
        -e|--env|--environment)
            ENV_SET=true
            ENVIRONMENT="$2"
            shift
            ;;
        --e|-env|-environment)
            echo "Valid environment options are -e | --env | --environment"
            echo "followed by the target environment."
            exit 1
            ;;
        *)
            #unknown option
            echo "Unknown option \"$1\", valid options are:"
            echo -e "\tEnvironment: -e | --env | --environment followed by target"
            echo -e "\tReset: -r | --reset"
            exit 1
            ;;
    esac
    shift
done

if [ $RESET ] || [ "$ENVIRONMENT" = "-r" ]; then
    if [ $ENV_SET ]; then
        #error
        echo "ERROR=cannot reset and specify an environment at the same time"
        exit 1
    else 
        ENVIRONMENT="general"
    fi
fi

if [ -z $ENVIRONMENT ]; then
    ENVIRONMENT="general"
fi

echo "Loading environment: \"$ENVIRONMENT\""
