# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
setopt AUTO_CD
setopt AUTO_LIST
setopt EXTENDEDGLOB #to be able to exclude some files

# Use vi keybindings
bindkey -v

#python
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

#gulp auto completion
eval "$(gulp --completion=zsh)"

if [[ `uname -s` == "Darwin"  ]]; then
    #osx stuff
    alias ls='ls -G'
    #homebrew path
    export PATH="/usr/local/bin:$PATH"
else
    #linux stuff
    alias ls='ls --color=auto'
fi

#personal bin dir
export PATH=$PATH:~/bin

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

#git
alias g='git'
alias gs='git status'
alias gst='git stash'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gcm="git commit -m '"
alias gca="git commit -am '"
alias gco='git checkout'
alias gcp='git cherry-pick'
alias glc='git ls-files | xargs wc -l'
alias gpo='git push origin'
alias gl4='gl 4'
alias gldate="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Creset %cD'"

function gl() {
    local arguments;
    if [[ -n "$1" ]]; then
        arguments=("-n$1" "${@:2}")
    else
        arguments=""
    fi

    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit $arguments
}

#extra config for this machine
if [[ -f ~/dotfiles/zsh_extra.sh ]]; then
    source ~/dotfiles/zsh_extra.sh
fi
