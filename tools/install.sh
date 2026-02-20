#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# --- Configuration ---
REPO_URL="https://github.com/nickael/wezterm.git"
TARGET_DIR="$HOME/.dotfiles"
ZSHRC_SOURCE="$TARGET_DIR/shell/zshrc.zsh"

echo "🚀 Starting remote ZSH configuration install..."

# 1. Clone or Update the Repository
if [ -d "$TARGET_DIR/.git" ]; then
  echo "📂 Repository already exists at $TARGET_DIR. Pulling latest..."
  cd "$TARGET_DIR" && git pull origin main
else
  echo "🌐 Cloning repository to $TARGET_DIR..."
  # Create the parent directories just in case they don't exist
  mkdir -p "$(dirname "$TARGET_DIR")"
  git clone "$REPO_URL" "$TARGET_DIR"
fi

# Verify the source file exists before proceeding
if [ ! -f "$ZSHRC_SOURCE" ]; then
  echo "❌ Error: Cannot find $ZSHRC_SOURCE. Clone may have failed."
  exit 1
fi

# 2. Backup existing .zshrc for the current user
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  echo "💾 Backing up existing $HOME/.zshrc to $HOME/.zshrc.bak"
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# 3. Create Symlink for the Current User
echo "🔗 Symlinking .zshrc for user: $USER..."
ln -sf "$ZSHRC_SOURCE" "$HOME/.zshrc"

# 4. Create Symlink for Root
echo "🔒 Symlinking .zshrc for root (will prompt for password)..."
sudo ln -sf "$ZSHRC_SOURCE" /var/root/.zshrc

# 5. Finalize
echo "✅ Installation complete!"
echo "🔄 Restart your terminal or run: source ~/.zshrc"
