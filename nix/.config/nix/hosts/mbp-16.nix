# Configuration specific to the mbp-16 MacBook
{ pkgs, username, ... }:
{
  environment.shells = [
    pkgs.bash
    pkgs.zsh
    pkgs.nushell
  ];

  # Define the user more explicitly
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # macOS-specific packages
  environment.systemPackages = with pkgs; [
    aerospace
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
