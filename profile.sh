
# Figuring out what system we on
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
elif [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

# searches previously used commands, by starting to type them
# and then click up, down
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# search cd in parallel in all these dirs
# for tab completion, check: bash-completion
export CDPATH=".:..:../..:/skype:/my"

# adding ~/bin/exec as path
export PATH=/my/config/bin:/usr/local/sbin:/usr/local/bin:$PATH

# increase bash_history size
HISTCONTROL=erasedups 
HISTSIZE=1000

if [[ $platform == 'osx' ]]; then
	alias ls="ls -hoGCF"
	alias l="ls -alGF"
 	alias e="open -a /Applications/Aquamacs.app/ "
	alias m="mate "
	alias o="open "
elif [[ $platform == 'linux' ]]; then
	alias ls="ls -G"
	alias e="emacs "
fi

# handy shortcuts
alias remotesql="sh /my/config/bin/remotesql.sh"
alias backup="sh /my/config/bin/backup.sh"

# diff
alias diff-ui="opendiff " # windowed diff
alias diff-svn="svn diff --diff-cmd diff-filemergesvn " # svn diff using filemerge

# jruby setup
export JRUBY_HOME=/my/config/bin/java/jruby-1.5.1
export PATH=$JRUBY_HOME/bin:$PATH

# rhino (for jslint)
alias rhino="java -jar /my/config/bin/javascript/rhino1_7R2/js.jar "
alias rhino-shell="java -cp /my/config/bin/javascript/rhino1_7R2/js.jar:/my/config/bin/javascript/jline.jar org.mozilla.javascript.tools.shell.Main -opt -1"    
alias rhino-debug="java -cp  /my/config/bin/javascript/rhino1_7R2/js.jar org.mozilla.javascript.tools.debugger.Main"
