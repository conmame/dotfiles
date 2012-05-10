export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH
export TERM=xterm

#補完
autoload -U compinit
compinit
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
#setopt share_history

#cd無くても空気を読む
setopt auto_cd

#移動したディレクトリを覚えさせる
autoload -U compinit
compinit
setopt auto_pushd

#間違ってたら教えて
setopt correct

#リストを詰めて表示
setopt list_packed

#beep鳴らさない
setopt nolistbeep
setopt NO_beep

#色をつける
case "${TERM}" in
    kterm*|xterm*)
      export LSCOLORS=exfxcxdxbxegedabagacad
      export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
      zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
      ;;
cons25)
       unset LANG
       export LSCOLORS=ExFxCxdxBxegedabagacad
       export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
       zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
       ;;
esac

alias ls="ls -G"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#historyを上書きしない
setopt append_history

#補完候補が複数ある時に一覧表示にする
setopt auto_list

#tabを連打するだけで順に補完候補を自動的に補完する
setopt auto_menu

#カッコの対応を自動で補完
setopt auto_param_keys

#ディレクトリ名の補完で末尾の/を自動で付加
setopt auto_param_slash

#{a-c}をa b cの様に展開
setopt brace_ccl

#戻り値が０以外の場合の終了コードを表示
setopt print_exit_value

#色を使う
setopt prompt_subst

bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-search-backward

#プロンプトを変更
autoload colors
colors

#補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

#補完候補の色づけ
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#カッコの対応などを自動的に補完
setopt auto_param_keys

#ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

#--prefix=/usr などの = 以降も補完
setopt magic_equal_subst

#補完候補一覧でファイルの種別をマーク表示
setopt list_types

#cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both
source /Users/con_mame/.zsh/zaw/zaw.zsh
zstyle ':filter-select' case-insentive yes
bindkey '^@' zaw-cdr

function rprompt-git-current-branch {
        local name st color

        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        echo "%{$color%}$name%{$reset_color%} "
}

case ${UID} in
0)
  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT="%{${fg[red]}%}%n%#%{${reset_color}%} "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  RPROMPT='[`rprompt-git-current-branch`%~]'
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

#ターミナルのタイトルを変更
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

alias st='open -a SourceTree `git rev-parse --show-toplevel`'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/
EC2_HOME=/opt/ec2-api-tools
EC2_CERT=
EC2_PRIVATE_KEY=
PATH=$PATH:$EC2_HOME/bin
export JAVA_HOME EC2_HOME EC2_CERT EC2_PRIVATE_KEY PATH
