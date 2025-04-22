# Configuration specific to the mbp-16 MacBook
{ pkgs, ... }:

{
  # macOS-specific packages
  environment.systemPackages = with pkgs; [
    bartender
    mkalias
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Adjust system settings
  system = {
    defaults = {
      dock = {
        autohide = true;
        minimize-to-application = true;
      };
    };
  };
}

