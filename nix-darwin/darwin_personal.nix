{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [

    ];

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    taps = [];
    brews = [];
    casks = [];

    masApps = {
    };
  };
}
