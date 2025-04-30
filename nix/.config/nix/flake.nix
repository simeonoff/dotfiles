{
  description = "Top level system flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Nix Darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Flake Utils
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, home-manager, nixpkgs, flake-utils, ... }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake ~/.config/nix#mbp-16
      darwinConfigurations."mbp-16" =
        let
          username = "SSimeonov";
        in
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit self username; };
          modules = [
            # Common configurations
            ./hosts/common.nix
            ./modules/packages.nix
            ./modules/system.nix
            ./modules/fonts.nix

            # macOS specific configurations
            ./hosts/mbp-16.nix
            ./modules/homebrew.nix

            # Homebrew module
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;

                # User owning the Homebrew prefix
                user = username;

                # Automatically migrate existing Homebrew installations
                autoMigrate = true;
              };
            }

            # Home Manager Module
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit username; };
                users.${username} = import ./home-manager/mbp-16/home.nix;
              };
            }
          ];
        };
    }
    # Merge with flake-utils outputs for development shells
    // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        devshells = import ./devshells/default.nix { inherit pkgs; };
      in
      {
        # Define development shells available on all platforms
        devShells = devshells;
      }
    );
}

