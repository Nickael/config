#!/bin/sh

if hash vim 2> /dev/null; then
    alias vi="vim"
fi

if hash docker 2> /dev/null; then
    alias d="docker"
fi
if hash docker-compose 2> /dev/null; then
    alias dk="docker-compose"
fi

if hash code-insiders 2> /dev/null; then
    alias code="code-insiders"
fi

if hash apt 2>/dev/null; then
    alias i="sudo apt update && sudo apt install -y"
    alias r="sudo apt autoremove --purge"
    alias s="sudo apt-cache search"
    alias u="sudo apt update && sudo apt upgrade"
elif hash yum 2>/dev/null; then
    alias i="sudo yum update && sudo yum install -y"
    alias r="sudo yum autoremove"
    alias s="sudo yum search"
    alias u="sudo yum update && sudo yum upgrade"
fi

if hash code-insiders 2> /dev/null; then
    alias code="code-insiders"
    alias c="code"
fi

if hash synaptic 2> /dev/null; then
    alias si="sudo synaptic"
fi

if hash dpkg 2> /dev/null; then
    alias di="sudo dpkg -i"
fi

# fancy ls / tree equivalent
if hash exa 2> /dev/null; then
    alias tree="exa --icons -T"
    alias t="tree"
    alias ls="exa --icons"
fi
if hash eza 2> /dev/null; then
    alias tree="eza --icons -T"
    alias t="tree"
    alias ls="eza --icons"
fi
# create angular and yarn alias if requirements are met
if hash node 2> /dev/null; then
    if hash ng 2> /dev/null; then
        alias ns="ng serve"
        alias nh="ng serve --host 0.0.0.0 --disable-host-check"
    fi

    if hash npm 2> /dev/null; then
        alias ni="npm i"
    fi

    if hash yarn 2> /dev/null; then
        alias yi="yarn install"
        alias ya="yarn add"
        alias yo="yarn outdated"
    fi
fi


alias l="ls"
alias ll="ls -l"
alias la="ls -la"
alias a="asdf"

alias cp="cp -v"
alias mv="mv -v"
alias mkdir="mkdir -v"
alias rm="rm -v"
alias ln="ln -v"

alias h="vi ~/.zsh_history"
alias vz="vi ~/.zshrc"
alias vb="vi ~/.bashrc"
alias va="vi ~/.shell/aliases.sh"
alias vs="vi ~/.shell/sources.sh"
alias sz="source ~/.zshrc"
alias vimrc="vi ~/.vimrc"
alias n="nvim"

alias sb="./bin/sb"
alias sbb="./bin/sbb"
alias docs="./bin/docs"

# nordvpn aliases 
if hash nordvpn 2> /dev/null; then
    alias nc="nordvpn c"
    alias nd="nordvpn d"
fi

alias q="exit"
alias po="sudo poweroff"
alias re="sudo reboot"

