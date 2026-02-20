#!/usr/bin/env bash

set -e

# --- Main Repo Config ---
REPO_URL="https://github.com/nickael/wezterm.git"
TARGET_DIR="$HOME/.dotfiles/"
SHELL_DIR="$TARGET_DIR/shell"
ZSHRC_SOURCE="$SHELL_DIR/zshrc.zsh"

# --- Theme Repo Config ---
THEME_REPO_URL="https://github.com/Nickael/ohmyposh.theme.git"
THEME_DIR="$HOME/.poshies"

# --- Datetime for Backups ---
CURRENT_DATETIME=$(date +"%Y%m%d_%H%M%S")

echo "🚀 Starting remote ZSH configuration install..."

# 1. Clone or Backup the Main Repository
if [ -d "$TARGET_DIR" ]; then
  BACKUP_FILE="${TARGET_DIR}_bak_${CURRENT_DATETIME}.tar.gz"
  echo "📂 Repository exists. Compressing current setup to $BACKUP_FILE..."
  # Compress relative to the parent directory to keep the archive clean
  tar -czf "$BACKUP_FILE" -C "$(dirname "$TARGET_DIR")" "$(basename "$TARGET_DIR")"
  rm -rf "$TARGET_DIR"
fi

echo "🌐 Cloning a clean repository to $TARGET_DIR..."
mkdir -p "$(dirname "$TARGET_DIR")"
git clone "$REPO_URL" "$TARGET_DIR"

# 2. Clone or Backup the Oh My Posh Theme
if [ -d "$THEME_DIR" ]; then
  THEME_BACKUP="${THEME_DIR}_bak_${CURRENT_DATETIME}.tar.gz"
  echo "🎨 Theme directory exists. Compressing to $THEME_BACKUP..."
  tar -czf "$THEME_BACKUP" -C "$(dirname "$THEME_DIR")" "$(basename "$THEME_DIR")"
  rm -rf "$THEME_DIR"
fi

echo "🎨 Cloning a clean Oh My Posh theme to $THEME_DIR..."
git clone "$THEME_REPO_URL" "$THEME_DIR"

# Verify the source directory and file exist
if [ ! -d "$SHELL_DIR" ] || [ ! -f "$ZSHRC_SOURCE" ]; then
  echo "❌ Error: Cannot find $SHELL_DIR or $ZSHRC_SOURCE."
  exit 1
fi

# 3. Setup Current User
echo "👤 Configuring for user: $USER..."
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  ZSHRC_BACKUP="$HOME/.zshrc_bak_${CURRENT_DATETIME}.tar.gz"
  echo "💾 Compressing existing $HOME/.zshrc to $ZSHRC_BACKUP"
  tar -czf "$ZSHRC_BACKUP" -C "$HOME" ".zshrc"
  rm -f "$HOME/.zshrc"
fi

# Link the directory and the entry point
ln -sfn "$SHELL_DIR" "$HOME/.shell"
ln -sf "$ZSHRC_SOURCE" "$HOME/.zshrc"

# 4. Setup Root Account (Interactive)
echo ""
read -r -p "❓ Do you want to configure the root account as well? [y/N] " config_root </dev/tty

if [[ "$config_root" =~ ^[Yy]$ ]]; then
  echo "🔒 Configuring for root (will prompt for password)..."
  if sudo [ -f "/var/root/.zshrc" ] && sudo [ ! -L "/var/root/.zshrc" ]; then
    ROOT_ZSHRC_BACKUP="/var/root/.zshrc_bak_${CURRENT_DATETIME}.tar.gz"
    echo "💾 Compressing existing root .zshrc to $ROOT_ZSHRC_BACKUP"
    sudo tar -czf "$ROOT_ZSHRC_BACKUP" -C "/var/root" ".zshrc"
    sudo rm -f "/var/root/.zshrc"
  fi

  # Link the directory and the entry point for root
  sudo ln -sfn "$SHELL_DIR" /var/root/.shell
  sudo ln -sf "$ZSHRC_SOURCE" /var/root/.zshrc
  echo "✅ Root configuration complete."
else
  echo "⏭️  Skipping root configuration."
fi

# 5. Finalize
echo ""
echo "✅ Installation complete!"
echo "🔄 Restart your terminal or run: source ~/.zshrc"
