. ~/.antigen.zsh

antigen bundle supercrabtree/k
antigen apply

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/sleepless/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e

# Remove duplications in zsh history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

stty -ixon
stty -ixoff

# Something from https://gist.github.com/luca-m/5957513
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


export VISUAL=micro
export EDITOR=micro
export PAGER=less


# Fuzzy search
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND="fd --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_R_OPTS="--height=100%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type directory --follow --color=always"
export FZF_ALT_C_OPTS="--ansi --preview 'tree -C {} | head -64'"
export FZF_COMPLETION_TRIGGER="*"


# Names coloring
. /usr/share/LS_COLORS/dircolors.sh
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey ";5A" beginning-of-line
bindkey ";5B" end-of-line
bindkey "e[3~" delete-char

trueclear() { true; clear; print -n -P "$PS1";}
zle -N trueclear
bindkey '^l' trueclear


alias ls='ls --color=auto'
alias tree='tree -C'
alias bc='bc -q'
alias bd='. bd -si'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# PS1='[%T] %F{%(?.green.red)}[%n@%M:%~]%f %# '
# PS1='[%T] %F{%(?.green.red)}[%-100(l.%n@%M:%~.%30<..<%~)]%f %# '
# PS1='%-40(l.[%T] .%T)%F{%(?.green.red)}[%-100(l.%n@%M:%~.%-40(l.%40<\s\s<%~.@))]%f %# '
PS1='%-47(l.[%T] .)%F{%(?.green.red)}%-100(l.[%n@%M:%~].%-40(l.[%25<..<%~].[]))%f %# '
PS2='> '
RPROMPT=''

export PATH=$PATH:.
export PATH=$PATH:~/Scripts


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


# Change title to current/last command
# trap 'echo -ne "\e]0;urxvt : $history[$HISTCMD]\007"' DEBUG


# Case insensetive tab competion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# Open new terminal in same directory
function open_urxvt() {urxvtc & disown}
zle -N open_urxvt
bindkey '^U' open_urxvt


# Common ctrl/shift selection behaivor
r-delregion() {
  if ((REGION_ACTIVE)) then
     zle kill-region
  else 
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}

r-deselect() {
  ((REGION_ACTIVE = 0))
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

r-select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

for key     kcap   seq        mode   widget (
    sleft   kLFT   $'\e[1;2D' select   backward-char
    sright  kRIT   $'\e[1;2C' select   forward-char
    sup     kri    $'\e[1;2A' select   up-line-or-history
    sdown   kind   $'\e[1;2B' select   down-line-or-history

    send    kEND   $'\E[1;2F' select   end-of-line
    send2   x      $'\E[4;2~' select   end-of-line

    shome   kHOM   $'\E[1;2H' select   beginning-of-line
    shome2  x      $'\E[1;2~' select   beginning-of-line

    left    kcub1  $'\EOD'    deselect backward-char
    right   kcuf1  $'\EOC'    deselect forward-char

    end     kend   $'\EOF'    deselect end-of-line
    end2    x      $'\E4~'    deselect end-of-line

    home    khome  $'\EOH'    deselect beginning-of-line
    home2   x      $'\E1~'    deselect beginning-of-line

    csleft  x      $'\E[1;6D' select   backward-word
    csright x      $'\E[1;6C' select   forward-word
    csend   x      $'\E[1;6F' select   end-of-line
    cshome  x      $'\E[1;6H' select   beginning-of-line

    cleft   x      $'\E[1;5D' deselect backward-word
    cright  x      $'\E[1;5C' deselect forward-word

    del     kdch1   $'\E[3~'  delregion delete-char
    bs      x       $'^?'     delregion backward-delete-char

  ) {
  eval "key-$key() {
    r-$mode $widget \$@
  }"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}
