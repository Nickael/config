# 🚀 Nickael's Zsh & Shell Configuration

This repository contains an automated, highly-optimized Zsh configuration designed for macOS. It seamlessly integrates modern CLI tools (Zoxide, Atuin, Oh My Posh) while maintaining strict compatibility and safety when switching to the `root` user.

## ✨ Features

* **One-Line Installation**: Fully automated setup script via `curl`.
* **Root-Safe Architecture**: Intelligently disables user-only plugins and Homebrew environment triggers when running as `root` to prevent permission errors (`command not found: compdef` or JWS JSON errors).
* **Automated Backups**: Safely backs up existing `.zshrc` and repository directories with a precise datetime stamp before making any changes.
* **Shared Theming**: Automatically clones and symlinks your custom Oh My Posh theme so both your local user and `root` share the exact same visual prompt.
* **Fast Loading**: Uses `znap` for asynchronous plugin loading.

---

## 📋 Requirements / Prerequisites

Before installing, ensure your macOS system has the following core utilities installed:

1. **Zsh**: (Default on modern macOS).
2. **Git**: Required to clone this repository and download plugins.
3. **Homebrew**: The package manager used for almost all tooling.
    ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/Nickael/config/main/tools/install.sh)"
    ```

### Required CLI Tools
The configuration expects the following tools to be installed via Homebrew. If they are missing, the shell will still load, but certain features will be disabled:
```bash
brew install atuin zoxide oh-my-posh
```
