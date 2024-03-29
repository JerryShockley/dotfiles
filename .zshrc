
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

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Use vi editing commands. This will override Neovim Terminal mode custom
# mapping of <Esc> as a short cut for <C-\><C-n> for entering Normal mode.
# In this case, you don't need this option as entering Normal mode
# inside a terminal buffer gives the full power of Neovim anyway.
# bindkey -v

### --> Alias
#
alias vim=nvim
alias vi=nvim

alias lj="ls -hHFGl"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias ljd="lj -a"
alias so="source ~/.zshrc"
alias -g zrc="~/.zshrc"
alias -g deploy="~/src/deploy"
alias -g roled="~/src/deploy/role_dev"
alias -g dotf="~/src/dotfiles"
alias ports="netstat -an | grep 'LISTEN'"
alias vplaybook="ansible-playbook -i 'hosts.ansible'  --private-key='~/.vagrant.d/insecure_private_key' -u vagrant playbook.yml"
alias al='alias | grep '
alias rgl="rg -L --hidden"
# eval `ssh-agent`
ssh-add -A  2>/dev/null


# Source asdf.sh
. $HOME/.asdf/asdf.sh
# add asdf competions $fpath
fpath=($HOME/.asdf/completions $fpath)
# . $HOME/.asdf/completions/asdf.bash
autoload -U compinit

for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

 source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
 source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh