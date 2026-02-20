#!/bin/zsh

[[ -r ~/.plugins/znap/znap.zsh ]] || git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.plugins/znap

source ~/.plugins/znap/znap.zsh

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source marlonrichert/zcolors
znap source mrjohannchang/zsh-interactive-cd
znap eval zcolors "zcolors ${(q)LS_COLORS}"

# 2. Conditional Homebrew Environment
# This prevents the "cannot as root" error in your screenshot
if [[ $UID -ne 0 ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  # If root, manually set the path so Atuin/Zoxide still work
  export PATH="/opt/homebrew/bin:$PATH"
fi

export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/node@22/lib"
export CPPFLAGS="-I/opt/homebrew/opt/node@22/include"
export HOMEBREW_NO_ENV_HINTS=true

eval "$(atuin init zsh)"
eval "$(zoxide init zsh --cmd cd)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://raw.githubusercontent.com/Nickael/ohmyposh.theme/master/.nr.nordic.k2.win.omp.json
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/Nickael/ohmyposh.theme/master/_Nordic_2026.omp.json')"
eval "$(oh-my-posh init zsh --config '~/Workspaces/github/ohmyposh.theme/_Nordic_2026.omp.json')"

export VAGRANT_DEFAULT_PROVIDER="virtualbox"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# This sets the variables for the current terminal session
export CFLAGS="-Wno-error=implicit-function-declaration"
export LDFLAGS="-L$(brew --prefix openssl@3)/lib -L$(brew --prefix readline)/lib"
export CPPFLAGS="-I$(brew --prefix openssl@3)/include -I$(brew --prefix readline)/include"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3) --with-readline-dir=$(brew --prefix readline)"

export PATH="/opt/homebrew/opt/php@8.4/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/php@8.4/lib"
export CPPFLAGS="-I/opt/homebrew/opt/php@8.4/include"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

#export TERM="wezterm"
export FURY_API_TOKEN="1XKQ8T-qp1TSm17fnzMej59WAXe03nLtI"
export WEZTERM_THEME="dark"

# . "$HOME/.local/bin/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
