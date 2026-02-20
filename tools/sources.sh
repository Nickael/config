#!/bin/sh

#[[ -r ~/.plugins/znap/znap.zsh ]] || git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.plugins/znap

#source ~/.plugins/znap/znap.zsh

#znap source marlonrichert/zsh-autocomplete
#znap source zsh-users/zsh-syntax-highlighting
#znap source zsh-users/zsh-autosuggestions
#znap source marlonrichert/zcolors
#znap source mrjohannchang/zsh-interactive-cd
#znap eval zcolors "zcolors ${(q)LS_COLORS}"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH="/home/linuxbrew/.linuxbrew/opt/node@22/bin:$PATH"
 export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/node@22/lib"
 export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/node@22/include"
export HOMEBREW_NO_ENV_HINTS=true

eval "$(atuin init zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(oh-my-posh init zsh --config '/home/nr/Workspace/_posh/.nr.nordic.k2.win.omp.json')"
#eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/Nickael/ohmyposh.theme/master/.nr.nordic.k2.win.omp.json')"


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export VAGRANT_DEFAULT_PROVIDER="virtualbox"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/nr/.lmstudio/bin"
