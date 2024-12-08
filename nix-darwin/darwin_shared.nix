{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      # General packages
      pkgs.aspell
      pkgs.aspellDicts.en
      pkgs.wget
      pkgs.zip

      # Text and terminal utilities
      pkgs.htop
      pkgs.jq
      pkgs.bat
      pkgs.ripgrep
      pkgs.tree
      pkgs.tmux
      #pkgs.unrar # enable allowunfree
      pkgs.unzip

      # Node.js development tools
      pkgs.nodePackages.npm # globally install npm
      pkgs.nodePackages.prettier
      pkgs.nodejs

      # Python packages
      pkgs.python3
      pkgs.pyenv

      # Rust
      pkgs.rustup
    ];

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    taps = [];
    brews = ["cowsay"];
    casks = [
      #"karabiner-elements"
      #"obsidian"
    ];

    masApps = {
     "Xcode" = 497799835;
    };
  };
}
