#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="git@github.com:distinctgrey/dotfiles.git"

# Install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
  export PATH="$HOME/.local/bin:$PATH"
fi

chezmoi init "$DOTFILES_REPO"
chezmoi apply -v
