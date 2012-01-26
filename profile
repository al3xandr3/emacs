
# in .bashrc
# source /my/config/profile

alias e="sublime-text-2" # editor
alias o="xdg-open"       # open

#shopt -s expand_aliases

# Figuring out what system we on
#platform='unknown'
#unamestr=`uname`
#if [[ "$unamestr" == 'Darwin' ]]; then
#   platform='osx'
#elif [[ "$unamestr" == 'Linux' ]]; then
#   platform='linux'
#fi

# searches previously used commands, by starting to type them
# and then click up, down
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'

# search cd in parallel in all these dirs
# for tab completion, check: bash-completion
#export CDPATH=".:..:../..:/skype:/my:/my/proj"

# adding ~/bin/exec as path
#export PATH=/my/config/bin:/usr/local/sbin:/usr/local/bin:$PATH

# increase bash_history size
#HISTCONTROL=erasedups 
#HISTSIZE=1000

#if [[ $platform == 'osx' ]]; then
#	alias ls="ls -hoGCF"
#	alias l="ls -alGF"
# 	alias e="open -a /Applications/Aquamacs.app/ "
#	alias m="mate "
#	alias o="open "
#elif [[ $platform == 'linux' ]]; then
#	alias ls="ls -G"
#	alias e="emacs "
#fi

# handy shortcuts
#alias remotesql="sh /my/config/bin/remotesql.sh"
#alias backup="sh /my/config/bin/backup.sh"

# diff
#alias diff-ui="opendiff " # windowed diff
#alias diff-svn="svn diff --diff-cmd diff-filemergesvn " # svn diff w/ filemerge

## ruby

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# my ruby
export RUBYLIB=/my/dev/ruby:$RUBYLIB

# libs folder
#libs=$(find /dmg/ruby -type d | grep 'lib$')
#for d in $libs; do 
# export RUBYLIB=$d:$RUBYLIB 
#done


# jruby setup
#export JRUBY_HOME=/dmg/ruby/jruby-1.6.2
#export PATH=$PATH:$JRUBY_HOME/bin

# rhino (for jslint)
#alias rhino="java -jar /my/config/bin/javascript/rhino1_7R2/js.jar "
#alias rhino-shell="java -cp /my/config/bin/javascript/rhino1_7R2/js.jar:/my/config/bin/javascript/jline.jar org.mozilla.javascript.tools.shell.Main -opt -1"    
#alias rhino-debug="java -cp  /my/config/bin/javascript/rhino1_7R2/js.jar org.mozilla.javascript.tools.debugger.Main"

#python
#export PYTHONPATH=/my/proj/python:$PYTHONPATH
