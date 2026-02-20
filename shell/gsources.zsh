#!/bin/zsh

# --- 1. Fix 'compdef not found' (Load Zsh Completions) ---
# This must happen before any tool (like atuin or zoxide) is initialized
autoload -Uz compinit
compinit

# Plugin Manager (Znap)
[[ -r ~/.plugins/znap/znap.zsh ]] || git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.plugins/znap
source ~/.plugins/znap/znap.zsh

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source marlonrichert/zcolors
znap source mrjohannchang/zsh-interactive-cd
znap eval zcolors "zcolors ${(q)LS_COLORS}"

# --- 2. User-Only Plugins & Brew Env (Skip for Root) ---
if [[ $UID -ne 0 ]]; then
  # Homebrew Env (Calling brew binary is safe here)
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Brew-dependent compiler flags
  export LDFLAGS="-L$(brew --prefix openssl@3)/lib -L$(brew --prefix readline)/lib"
  export CPPFLAGS="-I$(brew --prefix openssl@3)/include -I$(brew --prefix readline)/include"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3) --with-readline-dir=$(brew --prefix readline)"
else
  # Manual path for Root to avoid the "cannot as root" brew error
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# --- 3. Global Path & Tooling ---
export HOMEBREW_NO_ENV_HINTS=true
export PATH="/opt/homebrew/opt/node@22/bin:/opt/homebrew/opt/php@8.4/bin:$HOME/.rbenv/bin:$PATH"
export CFLAGS="-Wno-error=implicit-function-declaration"

# Initialize Tools (Safe for root now because PATH is set and compinit is run)
eval "$(atuin init zsh)"
eval "$(zoxide init zsh --cmd cd)"

# Note: Using ~ in paths for root will point to /var/root.
# Ensure the config file exists there if you want the same theme.
export POSH_THEME="~/Workspaces/github/ohmyposh.theme/_Nordic_2026.omp.json"

eval "$(oh-my-posh init zsh --config $POSH_THEME)"

# --- 4. Version Managers ---
eval "$(rbenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# --- 5. Environment Variables & SDKMAN ---
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
export FURY_API_TOKEN="1XKQ8T-qp1TSm17fnzMej59WAXe03nLtI"
export WEZTERM_THEME="dark"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
