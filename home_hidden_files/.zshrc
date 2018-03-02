
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=${PATH}:~/bin:~/workspace/tools
export PATH=${PATH}:~/install/android-sdk-linux/tools
export PATH=${PATH}:~/install/android-sdk-linux/platform-tools
export PATH=${PATH}:/usr/local/sbin
export PATH=${PATH}:/Applications/Postgres.app/Contents/Versions/9.4/bin
export PATH=$PATH:~/git/public/tools/hl/bin
export PATH=$PATH:/Users/koreiklein/training/go/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/.cabal/bin # Add RVM to PATH for scripting
export SMLROOT=/usr/local/sml

# export NVM_DIR="/home/koreiklein/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# source ~/.nvm/nvm.sh

# Prompt {{{
# Some quick color aliases for the prompt {{{
GRAY="%{"$'\033[0;30m'"%}"
BLACK="%{"$'\033[1;30m'"%}"
RED="%{"$'\033[0;31m'"%}"
HIRED="%{"$'\033[1;31m'"%}"
GREEN="%{"$'\033[0;32m'"%}"
HIGREEN="%{"$'\033[1;32m'"%}"
YELLOW="%{"$'\033[0;33m'"%}"
HIYELLOW="%{"$'\033[1;33m'"%}"
BLUE="%{"$'\033[0;34m'"%}"
HIBLUE="%{"$'\033[1;34m'"%}"
MAGENTA="%{"$'\033[0;35m'"%}"
HIMAGENTA="%{"$'\033[1;35m'"%}"
CYAN="%{"$'\033[0;36m'"%}"
HICYAN="%{"$'\033[1;36m'"%}"
WHITE="%{"$'\033[0;37m'"%}"
HIWHITE="%{"$'\033[1;37m'"%}"
BOLD="%{"$'\033[0;39m'"%}"
NORM="%{"$'\033[0m'"%}"
# }}}
# Set up the prompt {{{
source ~/.zshprompt # Machine specific, for different colors
# }}}
# }}}
# Environment variables {{{
VIMSYNTAX=/usr/share/vim/vim71/syntax
HISTFILE=~/.zshhistory            # What histfile are we using?
HISTSIZE=100000                   # Big = better
SAVEHIST=7000                     # When to save to the file?
export SHELL=`which zsh`                 # New shells don't open bash
export EDITOR=nvim
export GREP_OPTIONS='--color=auto'       # Color my greps
if [ $(uname) = Linux ]; then
   alias ls='ls --color=auto'
else
   export CLICOLOR=1
fi
# }}}
# Setopts {{{
#setopt auto_cd             # If I type a directory, assume I mean to cd to it
setopt auto_pushd          # Automatically push directories onto the stack
setopt badpattern          # Print an error message on badly formed glob
setopt cdablevars          # So we can cd to metachars like ~
#setopt correctall          # Attempt typo corrections
setopt complete_in_word    #
setopt extended_glob       # Allow ~ # ^ metachars in globbing
setopt extended_history    # More information in history
setopt hist_ignore_space   # Don't put space-prepended commands in the history
setopt interactivecomments # Allow comments even in the interactive shell
setopt listpacked          # Menucomplete can use different col widths
setopt markdirs            # Append / to all glob-completed dirs
setopt multios             # Allow multiple redirection!
setopt nobeep              # Don't beep
setopt no_flowcontrol      # No stupid flow control!
setopt nullglob            # Delete a glob if it doesn't match anything
setopt pushd_ignore_dups   # Don't push multiple copies of a directory
# }}}
# Autoloads {{{
autoload -U compinit; compinit
#autoload -U predict-on;
autoload edit-command-line
autoload copy-earlier-word
# }}}
# Zle {{{
zle -N predict-on;
zle -N predict-off;
zle -N edit-command-line
zle -N copy-earlier-word
# }}}
# Zstyles {{{
zstyle ':completion::complete:*' use-cache 1 # uses completion cache
# }}}

# Bindkeys {{{
bindkey -v                       # Use vim bindings
bindkey "^B" beginning-of-line   # This won't be screwed up by screen, but weird
bindkey "^E" end-of-line         # Like in bash
bindkey -v "^S" vi-change-whole-line
bindkey -a "^S" vi-change-whole-line
bindkey -v "^X" vi-kill-eol
bindkey -a "^X" vi-kill-eol
bindkey "^N" accept-and-infer-next-history # Enter; pop next history event
bindkey "^O" push-line           # Pushes line to buffer stack
bindkey "^P" get-line            # Pops top of buffer stack
bindkey "^R" history-incremental-search-backward # Like in bash, but should !
bindkey "^T" transpose-chars     # Transposes adjacent chars
bindkey "^Y" copy-earlier-word
bindkey "^Z" accept-and-hold     # Enter and push line
bindkey " " magic-space          # Expands from hist (!vim )
bindkey "^\\" pound-insert       # As an alternative to ctrl-c; will go in hist
bindkey "\e[3~" delete-char      # Enable delete
bindkey "^Q" predict-off        # Disable sweet complete-as-you-type
bindkey "^F" predict-on         # Enable sweet complete-as-you-type

# }}}
# Aliases {{{
# Misc {{{
alias i="info --vi-keys "
alias a='ls'
alias ao='ls -l'
alias ae='dirs -v'
alias cp='nocorrect cp'        # Don't correct this cmd
alias mkdir='nocorrect mkdir'  # Don't correct this cmd
alias mv='nocorrect mv'        # Don't correct this cmd
alias touch='nocorrect touch'  # Don't correct this cmd
alias sl='sl -l'               # ... dumb
# }}}
# Shortcuts {{{
alias 'web'='python -m SimpleHTTPServer' # hosts . on :8000
alias bc='bc -q -l'              # no warranty thing; loads math lib
alias broadcast='ifconfig | grep broadcast | tail -c 16'
alias cls='perl -e "print \"\e[2J\""' # prints a clearscreen - for termcast
alias hide='xset dpms force standby; exit' # kills my LCD monitor
# alias mouse='xmodmap -e "pointer = 1 2 3 6 7 8 9 10 4 5"' # fixes my buttons
alias ncscan='nc -v -z'          # scans ports with netcat
alias nmapscan='nmap -p'         # scans ports with nmap
alias probe='ping -i 50 `ifconfig | grep broadcast | tail -c 16`'
alias reload='source ~/.zshrc'   # re-sources this
alias restartx='sleep 5; startx' # restarts X!
alias tdA="todo -A"              # displays all todo items
alias usage='du -hs *'           # nicely displays disk usage of items in pwd
which htop>/dev/null && alias top='htop' # prettier version of top if it exists
# }}}
# Global shortcuts {{{
alias -g ...='../..'             # Ease of going backward
alias -g ....='../../..'         # Yes
alias -g .....='../../../..'     # YES
alias -g G='|egrep'              # cat biglongfile G cheese
alias -g H='|head'               # cat biglongfile H
alias -g L='|less'               # cat biglongfile L
alias -g T='|tail'               # cat biglongfile T
alias -g W='|wc'                 # cat biglongfile W
# }}}
# }}}

# Make
export CFLAGS="-Wall -O2 -std=c99"

#Bell
#xset b off
#Keyboard
alias rm='rm -i'
alias cp='cp -i'
alias revi='vim -S vimbook.vim'
alias vi='nvim'
alias vim='nvim'
alias t='date +%r'
alias dc='docker-compose'
alias dcp='docker-compose -f docker-compose.prod.yml'
alias dm='docker-machine'
#alias emacs='emacs -nw'

alias kc='kubectl'



unset DOCKER_TLS_VERIFY
unset DOCKER_HOST
unset DOCKER_CERT_PATH
unset DOCKER_MACHINE_NAME

# Virtualenvwrapper
#source /usr/local/bin/virtualenvwrapper.sh
#PROJECT_HOME=/Users/koreiklein/training/django

export GOPATH=~/go
export PATH=${PATH}:${GOPATH}/bin

# Secrets
source ~/.zshsecrets

