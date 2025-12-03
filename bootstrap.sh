#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/distinctgrey/dotfiles.git"

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

echo "🔧 Regenerating config file..."
chezmoi init

echo "📋 Applying dotfiles..."
chezmoi apply -v

echo ""
echo "⚠️  Note: The next step will install Homebrew and packages."
echo "   This requires sudo access and may prompt for your password."
echo "   If installation fails with 'need sudo access', run:"
echo "   sudo -v"
echo "   Then re-run any failed scripts manually."

echo "🔄 Switching to SSH remote for future operations..."
cd ~/.local/share/chezmoi
git remote set-url origin "git@github.com:distinctgrey/dotfiles.git"

echo "✨ Bootstrap complete!"
echo ""
echo "🔐 Next: Complete 1Password SSH setup"
echo "   After installing 1Password and configuring the SSH agent:"
echo "   Run: chezmoi-finalize-ssh"
echo ""
echo "   This will:"
echo "   - Verify 1Password SSH agent is working"
echo "   - Update SSH allowed signers file"
echo "   - Test Git commit signing"
