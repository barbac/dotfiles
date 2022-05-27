# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
setopt AUTO_CD
setopt AUTO_LIST
setopt EXTENDEDGLOB #to be able to exclude some files
#this prevents exiting when background process are running
setopt CHECK_JOBS

# Use vi keybindings
bindkey -v
#vim as default editor
export EDITOR=vim

#press ctrl-o to accept and keep selecting
zmodload zsh/complist
bindkey -M menuselect '\C-o' accept-and-menu-complete

#extra completion files
fpath=(~/dotfiles/completion $fpath)

#python
export WORKON_HOME=$HOME/.virtualenvs

if [[ `uname -s` == "Darwin"  ]]; then
    #osx stuff
    alias ls='ls -G'
    alias ffpro='/Applications/Firefox.app/Contents/MacOS/firefox --no-remote -p'
    #homebrew path
    export PATH="/usr/local/bin:$PATH"
    alias xcp='tmux save-buffer - | pbcopy'

    VIRTUALENVWRAPPER_PYTHON=`which python3`
    source /usr/local/bin/virtualenvwrapper.sh
else
    #linux stuff
    alias ls='ls --color=auto'
    alias ffpro='firefox -no-remote -P'
    alias xcp='tmux save-buffer - | xclip -i -selection clipboard'
    #local python(pip)
    export PATH="$HOME/.local/bin:$PATH"

    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi

#personal and yarn bin dir
export PATH=$PATH:~/bin:~/.yarn/bin

#expand aliases
globalias() {
   # if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   # fi
   zle self-insert
}
zle -N globalias
bindkey " " globalias
# control-space to bypass completion
bindkey "^ " magic-space
# normal space during searches
bindkey -M isearch " " magic-space

#aliases
alias m='make'
alias rm='nocorrect rm -i'
unalias mv
unalias cp
alias bcnc='python -m bCNC'

#default prettier options
alias -g pr='prettier --write'

#git
alias g='git'
alias gs='git status'
alias gst='git stash'
alias gsp='git stash pop'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gcm="git commit -m '"
alias gca="git commit -am '"
alias gco='git checkout'
alias gcp='git cherry-pick'
alias glc='git ls-files | xargs wc -l'
alias gpo='git push origin'
alias gp='git push'
alias gf='git fetch'
alias grh='git reset HEAD'
alias gl4='gl 4'
alias gldate="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Creset %cD'"

function gl() {
    local arguments;
    #test if it's numeric
    if [[ "$1" = <-> ]]; then
        arguments=("-n$1" "${@:2}")
    else
        arguments="$@"
    fi

    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit $arguments
}

#colors
alias diff='colordiff'

#tests

function test_this() {
    # BUFFER="alias testme='"$BUFFER"'"
    BUFFER="alias testme='"$BUFFER";  if [[ '"'$?'"' -eq 0 ]] then tmux rename-window ok; else tmux rename-window err; fi'"
    testhere
}
zle -N test_this
bindkey 'TTT' test_this

# alias testhere="tmux display-message -p 'let g:session=\"#S\"; let g:panel=\"#I.#P\"'"
function testhere() {
    tmux set-buffer "`tmux display-message -p 'let g:session="#S" | let g:panel="#I.#P"'`"
}

#extra config for this machine
if [[ -f ~/dotfiles/zsh_extra.sh ]]; then
    source ~/dotfiles/zsh_extra.sh
fi
