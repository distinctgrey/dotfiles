#!/usr/bin/env bash
set -euo pipefail

echo "=== Chezmoi ==="
command -v chezmoi && chezmoi --version
echo

echo "=== Homebrew ==="
command -v brew && brew --version
echo

echo "=== brew-file ==="
command -v brew && brew file --version || true
echo

echo "=== 1Password SSH Agent ==="
echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
if [ -S "$SSH_AUTH_SOCK" ]; then
  echo "SSH agent socket exists."
else
  echo "No SSH agent socket found. Enable it in 1Password."
fi
echo

echo "=== Drift ==="
chezmoi status || true
