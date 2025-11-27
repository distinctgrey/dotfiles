# Dotfiles (chezmoi + homebrew-file)

This repo manages my macOS setup using:
- **chezmoi** for dotfiles and machine bootstrap
- **Homebrew** for packages
- **homebrew-file + brew-wrap** to keep a Brewfile in sync with installs
- **1Password** for secrets and SSH keys (via 1Password SSH Agent)

## Prereqs (manual steps)
1. Sign in to the App Store if you use any App Store apps.
2. Install / sign in to **1Password** (or let Brewfile install it, then sign in).
3. In 1Password:
   - Enable **Settings → Developer → SSH Agent**.
   - Enable **Settings → Developer → Use 1Password as SSH agent**.
   - Make sure your SSH keys are stored in 1Password.

## Install on a new Mac

Run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/distinctgrey/dotfiles/main/scripts/bootstrap.sh)"
```

This will:
	1.	Install chezmoi if missing
	2.	Clone this repo into chezmoi
	3.	Apply dotfiles
	4.	Install Homebrew if missing
	5.	Install brew-file and all packages from ~/.Brewfile
	6.	Apply macOS defaults

After install, restart your terminal (zsh loads brew-wrap on startup).

## Update existing Mac

```bash
chezmoi update
```
This pulls the repo and reapplies changes.

## Add a new dotfile

```bash
chezmoi add ~/.somefile
chezmoi apply
```

Changes are automatically committed and pushed to the repo.

## Manage Homebrew packages

Brewfile is rendered by chezmoi from .chezmoidata/packages.yaml.

- Edit packages: change .chezmoidata/packages.yaml
- Re-render + install:

```bash
chezmoi apply
brew file install --file ~/.Brewfile
```

With brew-wrap enabled in .zshrc, normal Homebrew usage will update your Brewfile automatically. Commit those changes back into this repo by copying the updated entries into .chezmoidata/packages.yaml.

## Troubleshooting

Run diagnostics:

```bash
~/home/bin/doctor.sh
```

Check drift:

```bash
chezmoi status
chezmoi diff
```

## TODO

- Add a scrip to sync from Brewfile to the packages.yaml file in chezmoi
- Clean up README
- Find a way to sync application settings (e.g. Raycast)
