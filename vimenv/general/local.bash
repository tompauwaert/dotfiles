## ERROR FUNCTIONS
error(){
    echo -e "$@" 1>&2
}

fatal_error(){
    error "$@"
    exit 1
}


## Defining some colors for output.
black='\033[0;30m'
blue='\033[0;34m'
green='\033[0;32m'
cyan='\033[0;36m'
red='\033[0;31m'
purple='\033[0;35m'
orange='\033[0;33m'
light_gray='\033[0;37m'
dark_gray='\033[1;30m'
light_blue='\033[1;34m'
light_green='\033[1;32m'
light_cyan='\033[1;36m'
light_red='\033[1;31m'
light_purple='\033[1;35m'
yellow='\033[1;33m'
white='\033[1;37m'
NC='\033[0m' #no color

## Variables
DIR=~/work

## Shortcuts
alias ll='ls -al'
alias editgit='vim ~/.gitconfig<CR>'
alias editbash='vim ~/.bash_profile'
alias editvmr='vim ~/.vimrc'
alias resource='source ~/.bash_profile && echo "Done!"'
alias edittodo='vim ~/todo.txt'
alias vi=vim
alias tl1='tree -L 1 -C'
alias tl2='tree -L 2 -C'
alias tl3='tree -L 3 -C'
alias tl4='tree -L 4 -C'
alias vimenv='~/dotfiles/vimenv.sh'
alias ast='${DIR}/dev/tools/android-studio/bin/studio.sh'

## Switch repos
alias h='cd ~/'
alias w='cd ${DIR}'
alias bs='cd ${DIR}/bootstrap'
alias dev='cd ${DIR}/dev'
alias odev='cd ${DIR}/dev/odoo-dev'
alias dot='cd ~/dotfiles'
alias hr='cd ${DIR}/dev/hackerrank'
alias oop='cd ${DIR}/dev/one-off-projects' 

## HackerRank commands - making life easier
DEFAULT_HACKER_LANGUAGE=python
createHackFolder(){

    # If there's no arguments or the argument is --help or -h
    if [ $# -eq 0 ]; then
        echo "Usage of this command"
        echo "    challenge challenge_name solution_language"
        echo "> The language argument is optional. The language defaults to python"
        return 0
    fi

    if [ $1 == "--help" ] || [ $1 == "-h" ]; then
        echo "Usage of this command"
        echo "    challenge challenge_name solution_language"
        echo "> The language argument is optional. The language defaults to python"
        return 0
    fi;

    # check if folder does not already exists
    if [ ! -d "$1" ]; then
        mkdir $1
    fi
    cd $1

    # check if second folder is empty, and if not, whether it already exists.
    if [[ -z "$2" ]]; then
        if [ ! -d "$DEFAULT_HACKER_LANGUAGE" ]; then
            mkdir $DEFAULT_HACKER_LANGUAGE
        fi
        cd $DEFAULT_HACKER_LANGUAGE
    else
        if [ ! -d "$2" ]; then
            mkdir $2
        fi
        cd $2
    fi
}
alias challenge=createHackFolder
alias up2='cd ../..'

## Pull all repositories changes.
pullAll(){
    # Get and remember current path.
    currentPath="$PWD"

    # pull from dotfiles
    echo -e "${light_blue}Updating dotfiles... ${NC}"
    dot
    git pull

    echo -e "${light_blue}Updating odoo-dev... ${NC}"
    #pull from odoo-dev
    odev
    git pull

    echo -e "${light_blue}Updating hackerrank... ${NC}"
    #pull from hackerrank
    hr
    git pull

    echo -e "${light_blue}Updating one-off-projects... ${NC}"
    #pull from one-off-projects
    oop
    git pull

    echo -e "${light_purple}Updating completed.${NC}" 
    cd "$currentPath"
}
alias 'pull-all'=pullAll

_pushOrError(){
    repUpToDate=0
    line=$(git status | grep "nothing to commit")
    if [ -z "$line" ]; then
        error "${light_red}Repository has uncommited changes!${NC}" 
        return 0
    else
        git push
        return 1
    fi
}

pushAll(){
    # Get and remember current path.
    currentPath="$PWD"

    # push from dotfiles
    echo -e "${light_blue}Saving dotfiles... ${NC}"
    dot
    if _pushOrError; then
        return
    fi
    

    echo -e "${light_blue}Saving odoo-dev... ${NC}"
    # push from odoo-dev
    odev
    if _pushOrError; then
        return
    fi

    echo -e "${light_blue}Saving hackerrank... ${NC}"
    # push from hackerrank
    hr
    if _pushOrError; then
        return
    fi

    echo -e "${light_blue}Saving one-off-projects... ${NC}"
    # push from one-off-projects
    oop
    if _pushOrError; then
        return
    fi

    echo -e "${light_purple}Saving completed.${NC}" 
    cd "$currentPath"
}
alias 'push-all'=pushAll

## Git commands
alias log='git log'
alias diff='git diff'
alias branch='git branch'
alias st='git status'
alias fetch='git fetch'
alias push='git push origin HEAD'
alias pull='git pull'
alias fp='fetch && pull'
alias gmm='git merge master'
alias gmghp='git merge gh-pages'
alias recent='git for-each-ref --sort=-committerdate refs/heads/'
alias branch_new="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)'"

## Git branch switching
alias master='git co master'
alias ghp='git co gh-pages'

## Build tools
## alias gd='grunt dist'

## SVN
## alias up='svn up'
## alias sst='svn st'

## FORCE PROMPT COLORS
force_color_prompt=yes
#export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export LS_OPTS='--color=auto'
alias ls='ls ${LS_OPTS}'
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export TERM=screen-256color-bce

## Server guick starts
## alias ss='script/server'
## alias js='jekyll serve --watch'
## alias ps='python -m SimpleHTTPServer 4000'
## alias gtest='testrb test/integration/bundle_test.rb'
