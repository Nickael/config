#!/bin/zsh

if [ -d ~/.shell ]; then
   . $HOME/.shell/gsources.zsh
   . $HOME/.shell/aliases.zsh
fi

if [[ "$TERM" != "xterm-256color" ]]; then
  export TERM="xterm-256color"
fi

export PAGER="less -RF"
