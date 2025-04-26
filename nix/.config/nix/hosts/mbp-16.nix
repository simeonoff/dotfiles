# Configuration specific to the mbp-16 MacBook
{ pkgs, ... }:

let
  username = "SSimeonov";
in
{
  environment.shells = [
    pkgs.bash
    pkgs.zsh
    pkgs.nushell
  ];

  users.users.${username}.shell = pkgs.zsh;

  programs.zsh.enable = true;
  programs.zsh.promptInit = ''
    exec ${pkgs.nushell}/bin/nu
  '';

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

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
