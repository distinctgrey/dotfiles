#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="git@github.com:distinctgrey/dotfiles.git"

# Complete chezmoi reset - remove everything before starting fresh
echo "🧹 Cleaning up existing chezmoi setup..."

# Remove all chezmoi-managed files from home directory (if chezmoi exists)
if command -v chezmoi >/dev/null 2>&1; then
  chezmoi remove --all 2>/dev/null || true
fi

# Remove chezmoi configuration and data directories
rm -rf ~/.config/chezmoi
rm -rf ~/.local/share/chezmoi
rm -rf ~/.local/state/chezmoi
rm -rf ~/.cache/chezmoi

echo "✅ Chezmoi cleanup complete"

# Install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "📦 Installing chezmoi..."
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
  export PATH="$HOME/.local/bin:$PATH"
fi

echo "🚀 Initializing chezmoi with dotfiles..."
chezmoi init "$DOTFILES_REPO"

echo "📋 Applying dotfiles..."
chezmoi apply -v

echo "✨ Bootstrap complete!"
