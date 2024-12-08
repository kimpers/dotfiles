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
      "mitmproxy"
      "tfenv"
    ];
    casks = [];

    masApps = {
      "Yubico Authenticator" = 1497506650;
    };
  };
}
