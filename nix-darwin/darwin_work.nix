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
      "awscli"
      "kubernetes-cli"
      "k6"
      "k9s"
      "helm"
      "grpcurl"
      "kops"
      "kubeseal"
      "minikube"
      "logcli"
      "tfenv"
      # Yubikey
      "gpg"
      "ykpers"
      "pinentry"
      "pinentry-mac"
      "ykman"
    ];
    casks = [
      "mitmproxy"
    ];

    masApps = {
      "Yubico Authenticator" = 1497506650;
    };
  };
}
