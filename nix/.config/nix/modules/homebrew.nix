# Homebrew configuration for macOS
{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "ninja"
    ];
    casks = [
      "1password"
      "amethyst"
      "firefox"
      "font-symbols-only-nerd-font"
      "ghostty"
      "iina"
      "the-unarchiver"
    ];
    onActivation = {
      # Uncomment after a new install
      # cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  # Set up Nix apps in /Applications
  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    lib.mkForce ''
      #Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
}

