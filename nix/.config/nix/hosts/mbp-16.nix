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

  # We'll handle the revision in the main flake.nix file
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;
}