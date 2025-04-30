{ lib, config, pkgs, username, ... }:

{
  # Home Manager configuration
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  xdg.enable = true;

  programs.nushell = {
    enable = true;
  };

  # Configure direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        log_format = "-";
        log_filter = "^$";
      };
    };
  };
}
