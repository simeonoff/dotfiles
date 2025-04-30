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

  programs.zsh = {
    enable = true;
    initExtra = ''
      # Use Nushell as the default shell
      exec ${pkgs.nushell}/bin/nu
    '';
  };

  programs.nushell = {
    enable = true;
    configFile.source = ./config/nushell/config.nu;
    envFile.source = ./config/nushell/env.nu;
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = false;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        log_format = "-";
        log_filter = "^$";
      };
    };
  };
}
