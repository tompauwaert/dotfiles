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
VIMENV_DIR="vimenv"
VIMENV="${DIR}/${VIMENV_DIR}"

LIGHT_GREEN='\033[0;32m'
NC='\033[0m'

ACTIVE="active_environment"
GENERAL="general"
PLUGIN="plugin"
BUNDLE="bundle"
CURRENT="current.env"
NUM_ARG="$#"

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
        echo "ERROR: Cannot reset and specify an environment at the same time"
        exit 1
    else 
        ENVIRONMENT="${GENERAL}"
    fi
fi

if [ $NUM_ARG -eq 0 ]; then
    echo "Currently active environment: "
    cat "${VIMENV}/${ACTIVE}/${CURRENT}"
    exit 0
else 
    if [ -z $ENVIRONMENT ]; then
        ENVIRONMENT=${GENERAL}
    fi
fi

function load_general(){
    # the shopt command makes sure that if the folder is empty the
    # for is not executed. Otherwise, even if the folder is empty 
    # the for loop would be executed once with the value *
    echo "Loading environment: general"
    shopt -s nullglob
    for plugin in "${VIMENV}/${GENERAL}/${PLUGIN}/${BUNDLE}"/*
    do
        plugin_name="$(basename $plugin)"
        if [ ! -f "${VIMENV}/${ACTIVE}/${PLUGIN}/${BUNDLE}/$plugin_name" ]; 
        then
            ln -s "${plugin}" \
                "${VIMENV}/${ACTIVE}/${PLUGIN}/${BUNDLE}/$plugin_name"
        fi
    done
    shopt -u nullglob
}

function load_environment(){
    clean_active
    echo "Loading environment: $ENVIRONMENT"
    echo "${ENVIRONMENT}" >> "${VIMENV}/${ACTIVE}/${CURRENT}"
    ln -s "${VIMENV}/${ENVIRONMENT}/local.vim" "${VIMENV}/${ACTIVE}/local.vim"
    ln -s "${VIMENV}/${ENVIRONMENT}/local.bash" "${VIMENV}/${ACTIVE}/local.bash"
    if [ -d "${VIMENV}/${ENVIRONMENT}/${PLUGIN}/${BUNDLE}" ]; then
        ln -s "${VIMENV}/${ENVIRONMENT}/${PLUGIN}" \
            "${VIMENV}/${ACTIVE}/${PLUGIN}"
    else
        mkdir -p "${VIMENV}/${ACTIVE}/${PLUGIN}/${BUNDLE}" 
    fi
    load_general
    echo -e "${LIGHT_GREEN}Loading environments [completed]${NC}"
}

function clean_active(){
    if [ -d "${VIMENV}/${ACTIVE}" ]; then
        rm "${VIMENV}/${ACTIVE}/"local.* 2> /dev/null

        if [ -d "${VIMENV}/${ACTIVE}/${PLUGIN}/${BUNDLE}" ]; then
            find "${VIMENV}/${ACTIVE}/${PLUGIN}/${BUNDLE}" \
                -maxdepth 1 -type l -exec rm {} \;
        fi

        rm "${VIMENV}/${ACTIVE}/${PLUGIN}" 2> /dev/null
        # It might also be an actual directory instead of a symlink
        rm -r "${VIMENV}/${ACTIVE}/${PLUGIN}" 2> /dev/null
        rm "${VIMENV}/${ACTIVE}/${CURRENT}" 2> /dev/null
    fi
}

function only_general(){
    echo "${GENERAL}" >> "${VIMENV}/${ACTIVE}/${CURRENT}"
    ln -s "${VIMENV}/${GENERAL}/${PLUGIN}" "${VIMENV}/${ACTIVE}/${PLUGIN}"
}

if [ "${ENVIRONMENT}" == "${GENERAL}" ]; then
    clean_active
    only_general
else 
    if [ ! -d "${VIMENV}/${ENVIRONMENT}" ]; then
        echo "ERROR: Environment \"${ENVIRONMENT}\" does not exist!"
    else
        load_environment
    fi
fi

