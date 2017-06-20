# minimally comfortable bashrc

LS_COLORS=$LS_COLORS:'ow=40;32:di=00;34:ln=00;36:*.gitignore=01;32:' ; export LS_COLORS
alias l="ls --color=auto -Fal"
alias cls='echo -en "\e[3J"'
alias o="xdg-open"
alias please='echo "sudo $(fc -ln -1)"; sudo $(fc -ln -1)'

# List folders
alias lf='l | grep "^d"' #Only list directories, including hidden ones
