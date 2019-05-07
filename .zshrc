
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# for config_file ($ZSH/**/*.zsh) [[ "$(basename $config_file)" == "completion.zsh" ]] || source $config_file

fpath=(/usr/local/share/zsh-completions $HOME/zprezto/modules/completion/external/src $fpath)


###  -->  Exports
# This makes switching vim modes on command lines faster. It may have unforseen side effects.
export KEYTIMEOUT=1
export EDITOR=nvim
export SHELL=/usr/local/bin/zsh
export VISUAL=$EDITOR
export ECLIPSE_HOME=$HOME/eclipse-workspace

# 10 second wait if you do something that will delete everything
setopt RM_STAR_WAIT
# Case insensitive globbing
setopt NO_CASE_GLOB
# Use extended glob syntax
setopt EXTENDED_GLOB

### -->  Key Mappings
# Map up and down arrow keys to history substring search motions
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Map Vim up and down movement keys to history substring search motions
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

###  -->  Functions
#
# myIP address
function myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
	ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# load the function-based completion system. Only uncomment if Prezto is removed as Prezto does this.
# autoload -U compinit
# compinit


# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Use vi editing commands
bindkey -v

### --> Alias
#
alias vim=nvim
alias vi=nvim

alias lj="ls -hWFGl"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias ljd="lj -a"
alias so="source ~/.zshrc"
alias -g zrc="~/.zshrc"
alias -g nviminit="~/.config/nvim/init.vim"
alias -g prc="~/.zpreztorc"
alias -g edir="~/src/elixir"
alias -g bdir="~/src/book_code"

# eval `ssh-agent`
ssh-add -A  2>/dev/null



. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
