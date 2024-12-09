{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [

    ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [];
    brews = [
      "diff-pdf"
      "duck"
      "ffmpeg"
      "imagemagick"
      "p7zip"
    ];
    casks = [
      "rar"
      "smcfancontrol"
      "vlc"
      "transmission"
      "discord"
      "arc"
      "cleanmymac"
      "little-snitch"
      "slack"
    ];

    masApps = {
      "Bear"= 1091189122;
      "The Unarchiver"= 425424353;
      "Todoist"= 585829637;
    };
  };
}
