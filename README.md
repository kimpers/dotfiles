# dotfiles

My dotfiles and folders

# Install instructions

1. Clone repository
1. Install and setup [nix-darwin](https://github.com/LnL7/nix-darwin)
   1. Test build a configuration for a computer: `darwin-rebuild build --flake .#Kims-MacBook-Pro-2`
   1. Switch to the configuration: `darwin-rebuild switch --flake ~/.dotfiles/nix-darwin/`
1. Run `darwin-rebuild switch` to install all packages
1. Open `Cursor` and import the `default.code-profile`. **NOTE:** This needs to be done before the install script is run
1. Run scripts/install to setup configuration
   _this will remove any custom oh-my-zsh plugins already installed in order to get the symlinks working_
