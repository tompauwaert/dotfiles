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
#alias dark='~/dotfiles/gnome-terminal-colors-solarized/set_dark.sh'
#alias light='~/dotfiles/gnome-terminal-colors-solarized/set_light.sh'
alias dvim='~/dotfiles/dvim.sh'
alias lvim='~/dotfiles/lvim.sh'


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

## Switch repos
DIR=~/work
alias h='cd ~/'
alias w='cd ${DIR}'
alias bs='cd ${DIR}/bootstrap'
alias dev='cd ${DIR}/dev'
alias odev='cd ${DIR}/dev/odoo-dev'
alias dot='cd ~/dotfiles'

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

## Core GitHub apps
## alias gh='cd ~/github'
## alias gg='cd ~/github/github'
## alias ggg='gg && script/server'
## alias giants='cd ~/github/giants'
## alias hire='cd ~/github/hire'
## alias summit='cd ~/github/summit'
## alias primer='cd ~/github/primer'

## Server guick starts
## alias ss='script/server'
## alias js='jekyll serve --watch'
## alias ps='python -m SimpleHTTPServer 4000'
## alias gtest='testrb test/integration/bundle_test.rb'

## Mobile iOS testing
## alias ios='open /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app'

# Added by the Heroku Toolbelt
## export PATH="/usr/local/heroku/bin:$PATH"
