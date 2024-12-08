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
      pkgs.nodePackages.yarn
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
    onActivation.cleanup = "uninstall";

    taps = [
      "nikitabobko/tap"
    ];
    brews = [
      "ack"
      "act"
      "openssl"
      "axel"
      "bat"
      "cargo-instruments"
      "cmake"
      "gnutls"
      "pinentry"
      "pinentry-mac"
      "gnupg"
      "gpgme"
      "pam-u2f"
      "ykman"
      "ykpers"
      "openjdk"
      "fd"
      "findutils"
      "fzf"
      "gawk"
      "gh"
      "git"
      "git-delta"
      "gnu-tar"
      "go"
      "htop"
      "httpie"
      "grep"
      "jd"
      "jq"
      "just"
      "hub"
      "libfido2"
      "neovim"
      "luarocks"
      "llvm"
      "n"
      "parallel"
      "pgcli"
      "shellcheck"
      "trash"
      "watch"
      "wget"
      "yq"
      "zlib"
      "zplug"
      "zsh"
      "oven-sh/bun/bun"
    ];
    casks = [
      "obsidian"
      "warp"
      "1password-cli"
      "marta"
      "aerospace"
      "karabiner-elements"
    ];

    masApps = {
      "Xcode" = 497799835;
      "Yubico Authenticator" = 1497506650;
    };
  };
}
