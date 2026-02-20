#!/usr/bin/env bash

set -e

# --- Universal Color Output Variables ---
RED=$(printf '\033[0;31m')
GREEN=$(printf '\033[0;32m')
YELLOW=$(printf '\033[1;33m')
BLUE=$(printf '\033[0;34m')
MAGENTA=$(printf '\033[0;35m')
CYAN=$(printf '\033[0;36m')
NC=$(printf '\033[0m') # No Color

# --- Main Repo Config ---
REPO_URL="https://github.com/nickael/wezterm.git"
TARGET_DIR="$HOME/.dotfiles"
SHELL_DIR="$TARGET_DIR/shell"
ZSHRC_SOURCE="$SHELL_DIR/zshrc.zsh"

# --- Theme Repo Config ---
THEME_REPO_URL="https://github.com/Nickael/ohmyposh.theme.git"
THEME_DIR="$HOME/.poshies"

# --- Datetime for Backups ---
CURRENT_DATETIME=$(date +"%Y%m%d_%H%M%S")

echo "${CYAN}🚀 Starting remote ZSH configuration install...${NC}"

# 1. Clone or Backup the Main Repository
if [ -d "$TARGET_DIR" ]; then
  BACKUP_FILE="${TARGET_DIR}_bak_${CURRENT_DATETIME}.tar.gz"
  echo "${YELLOW}📂 Repository exists. Compressing current setup to ${BACKUP_FILE}...${NC}"
  tar -czf "$BACKUP_FILE" -C "$(dirname "$TARGET_DIR")" "$(basename "$TARGET_DIR")"
  rm -rf "$TARGET_DIR"
fi

echo "${BLUE}🌐 Cloning a clean repository to ${TARGET_DIR}...${NC}"
mkdir -p "$(dirname "$TARGET_DIR")"
git clone -q "$REPO_URL" "$TARGET_DIR"

# 2. Clone or Backup the Oh My Posh Theme
if [ -d "$THEME_DIR" ]; then
  THEME_BACKUP="${THEME_DIR}_bak_${CURRENT_DATETIME}.tar.gz"
  echo "${YELLOW}🎨 Theme directory exists. Compressing to ${THEME_BACKUP}...${NC}"
  tar -czf "$THEME_BACKUP" -C "$(dirname "$THEME_DIR")" "$(basename "$THEME_DIR")"
  rm -rf "$THEME_DIR"
fi

echo "${BLUE}🎨 Cloning a clean Oh My Posh theme to ${THEME_DIR}...${NC}"
mkdir -p "$(dirname "$THEME_DIR")"
git clone -q "$THEME_REPO_URL" "$THEME_DIR"

# Verify the source directory and file exist
if [ ! -d "$SHELL_DIR" ] || [ ! -f "$ZSHRC_SOURCE" ]; then
  echo "${RED}❌ Error: Cannot find ${SHELL_DIR} or ${ZSHRC_SOURCE}.${NC}"
  exit 1
fi

# 3. Setup Current User
echo "${CYAN}👤 Configuring for user: ${USER}...${NC}"
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  ZSHRC_BACKUP="$HOME/.zshrc_bak_${CURRENT_DATETIME}.tar.gz"
  echo "${YELLOW}💾 Compressing existing ${HOME}/.zshrc to ${ZSHRC_BACKUP}${NC}"
  tar -czf "$ZSHRC_BACKUP" -C "$HOME" ".zshrc"
  rm -f "$HOME/.zshrc"
fi

# Link the directory and the entry point
ln -sfn "$SHELL_DIR" "$HOME/.shell"
ln -sf "$ZSHRC_SOURCE" "$HOME/.zshrc"

# 4. Setup Root Account (Interactive)
echo ""
read -r -p "${MAGENTA}❓ Do you want to configure the root account as well? [y/N] ${NC}" config_root </dev/tty

if [[ "$config_root" =~ ^[Yy]$ ]]; then
  echo "${CYAN}🔒 Configuring for root (will prompt for password)...${NC}"
  if sudo [ -f "/var/root/.zshrc" ] && sudo [ ! -L "/var/root/.zshrc" ]; then
    ROOT_ZSHRC_BACKUP="/var/root/.zshrc_bak_${CURRENT_DATETIME}.tar.gz"
    echo "${YELLOW}💾 Compressing existing root .zshrc to ${ROOT_ZSHRC_BACKUP}${NC}"
    sudo tar -czf "$ROOT_ZSHRC_BACKUP" -C "/var/root" ".zshrc"
    sudo rm -f "/var/root/.zshrc"
  fi

  # Link the directories and entry point for root
  sudo ln -sfn "$SHELL_DIR" /var/root/.shell
  sudo ln -sf "$ZSHRC_SOURCE" /var/root/.zshrc

  # Symlink the new poshies directory so root has access to the theme
  sudo ln -sfn "$THEME_DIR" /var/root/.poshies

  echo "${GREEN}✅ Root configuration complete.${NC}"
else
  echo "${YELLOW}⏭️  Skipping root configuration.${NC}"
fi

# 5. Finalize
echo ""
echo "${GREEN}✅ Installation complete!${NC}"
echo "${CYAN}🔄 Restart your terminal or run: source ~/.zshrc${NC}"
