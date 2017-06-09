# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/sleepless/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

# Something from https://gist.github.com/luca-m/5957513
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey ";5A" beginning-of-line
bindkey ";5B" end-of-line

# End of lines configured by zsh-newuser-install


alias ls='ls --color=auto'
alias tree='tree -C'
alias bc='bc -q'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

PS1='[%T] %F{%(?.green.red)}[%n@%M:%~]%f %# '
PS2='> '
RPROMPT=''

export PATH=$PATH:.

zstyle ':completion:*' rehash true

#when we create new function or install new bin , the default zsh cant get the new completion for us,so we 
#can add a new function for this problem,you can add the blow content in your .zshrc file
function reload_autocomlete() {
         if [[ "$#*" -eq 0 ]]; then
                 test -r /etc/zsh/zsh-oli && . /etc/zsh/zsh-oli
                 test -r ~/.zshrc && . ~/.zshrc
                 return 0
         else
                 local fn
                 for fn in $*; do
                    unfunction $fn
                    autoload -U $fn
                 done
         fi
}
compdef _functions reload