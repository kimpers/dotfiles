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

   environment.darwinConfig = "$HOME/.dotfiles/nix-darwin";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;  # default shell on catalina
  };

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
     "Yubico Authenticator" = 1497506650;
     "Xcode" = 497799835;
    };
  };


  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      "com.apple.keyboard.fnState" = true;
    };
  };
}
