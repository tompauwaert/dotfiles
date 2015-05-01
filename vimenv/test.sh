#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
VIMENV_DIR="vimenv"
VIMENV="${DIR}"

ACTIVE="active_environment"
GENERAL="general_test"
TEST="test_dir"
PLUGINC="plugin/bundle"
PLUGIN="plugin"
BUNDLE="bundle"

function make_test(){
    echo "make_test"
    touch "${VIMENV}/${TEST}/local.vim"
    touch "${VIMENV}/${TEST}/local.bash"
    mkdir -p  "${VIMENV}/${TEST}/${PLUGINC}/plug1"
    mkdir -p  "${VIMENV}/${TEST}/${PLUGINC}/plug2"
    mkdir -p  "${VIMENV}/${TEST}/${PLUGINC}/plug3"
    mkdir -p  "${VIMENV}/${TEST}/${PLUGINC}/plug4"
    mkdir -p  "${VIMENV}/${TEST}/${PLUGINC}/Vundle.vim"
    touch "${VIMENV}/${TEST}/${PLUGINC}/plug1/file.vim"
    touch "${VIMENV}/${TEST}/${PLUGINC}/plug2/file.vim"
    touch "${VIMENV}/${TEST}/${PLUGINC}/plug3/file.vim"
    touch "${VIMENV}/${TEST}/${PLUGINC}/plug4/file.vim"
    touch "${VIMENV}/${TEST}/${PLUGINC}/Vundle.vim/Vundle.vim"
}

function make_test_active(){
    echo "make_test_active"
    ln -s "${VIMENV}/${TEST}/${PLUGIN}" "${VIMENV}/${ACTIVE}/${PLUGIN}"
    ln -s "${VIMENV}/${TEST}/local.vim" "${VIMENV}/${ACTIVE}/local.vim"
    ln -s "${VIMENV}/${TEST}/local.bash" "${VIMENV}/${ACTIVE}/local.bash"

    # Because when running this twice it creates this weird link.
    if [ -d "${VIMENV}/${TEST}/${PLUGIN}/plugin" ]; then
        rm "${VIMENV}/${TEST}/${PLUGIN}/plugin"
    fi
}

function make_general(){
    sudo rm -rf "${VIMENV}/general_test"
    cp -r "${VIMENV}/general" "${VIMENV}/general_test"
}

function add_general(){
    echo "add_general"

    # the shopt command makes sure that if the folder is empty the
    # for is not executed. Otherwise, even if the folder is empty 
    # the for loop would be executed once with the value *
    shopt -s nullglob
    for plugin in "${VIMENV}/${GENERAL}/${PLUGINC}"/*
    do
        plugin_name="$(basename $plugin)"
        ln -s "${plugin}" "${VIMENV}/${ACTIVE}/${PLUGINC}/$plugin_name"
    done
    shopt -u nullglob
}

make_test
make_test_active
make_general
add_general





