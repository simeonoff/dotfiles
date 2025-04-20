# Nix Configuration Guide & Conversation History

## Table of Contents

1. [Initial Setup - Node.js Development Environment](#initial-setup---nodejs-development-environment)
2. [Adding Multiple Node.js Versions](#adding-multiple-nodejs-versions)
3. [Using flake-utils for Multi-Platform Support](#using-flake-utils-for-multi-platform-support)
4. [Restructuring the Configuration](#restructuring-the-configuration)
5. [Custom Font Integration](#custom-font-integration)

## Initial Setup - Node.js Development Environment

**User:** I'm very new to this nix thing. Decided to move my configuration to it in case I need to replicate it on another machine. Now, I don't know the nix language or anything about advanced configuration, I've been following tutorials mostly. I want to create a shell environment with a specific version of nodejs installed in it which later on I can use in a project using .envrc with use flake inside. This .envrc will be loaded using direnv allow. How can I achieve this using my flake.nix config?

**Claude:** Let me help you set up a Nix flake for a specific Node.js version and explain how to use it with direnv.

I'll add a `devShell` output to your flake that creates a development environment with Node.js:

```nix
# Development shell with specific Node.js version
# Usage: nix develop ~/.config/nix#nodejs18
devShells."aarch64-darwin".nodejs18 = 
  let
    pkgs = import nixpkgs { system = "aarch64-darwin"; };
  in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      nodejs-18_x
    ];
    
    # Shell hook with info message
    shellHook = ''
      echo "Node.js $(node --version) development environment"
      echo "Use with direnv by adding 'use flake ~/.config/nix#nodejs18' to your .envrc file"
    '';
  };
```

To use this environment:

1. Test it directly with: `nix develop ~/.config/nix#nodejs18`

2. For projects with direnv:
   - Create a `.envrc` file in your project directory with: `use flake ~/.config/nix#nodejs18`
   - Run `direnv allow` in that directory

This will automatically activate your Node.js environment whenever you enter that project directory.

## Adding Multiple Node.js Versions

**User:** Can I add as many devShells as I want using the same approach so I can load more versions if I wanted?

**Claude:** Yes, you can add as many devShells as you want. Here's how you can extend your flake.nix with multiple Node.js versions:

```nix
# Development shells with different Node.js versions
# Common setup for devShells
devShells."aarch64-darwin" = 
  let
    pkgs = import nixpkgs { system = "aarch64-darwin"; };
  in
  {
    # Node.js 16.x environment
    # Usage: nix develop ~/.config/nix#nodejs16
    nodejs16 = pkgs.mkShell {
      buildInputs = with pkgs; [
        nodejs-16_x
      ];
      
      shellHook = ''
        echo "Node.js $(node --version) development environment"
        echo "Use with direnv by adding 'use flake ~/.config/nix#nodejs16' to your .envrc file"
      '';
    };
    
    # Node.js 18.x environment
    # Usage: nix develop ~/.config/nix#nodejs18
    nodejs18 = pkgs.mkShell {
      buildInputs = with pkgs; [
        nodejs-18_x
      ];
      
      shellHook = ''
        echo "Node.js $(node --version) development environment"
        echo "Use with direnv by adding 'use flake ~/.config/nix#nodejs18' to your .envrc file"
      '';
    };
    
    # Node.js 20.x environment
    # Usage: nix develop ~/.config/nix#nodejs20
    nodejs20 = pkgs.mkShell {
      buildInputs = with pkgs; [
        nodejs-20_x
      ];
      
      shellHook = ''
        echo "Node.js $(node --version) development environment"
        echo "Use with direnv by adding 'use flake ~/.config/nix#nodejs20' to your .envrc file"
      '';
    };
  };
```

You can follow this same pattern for other development environments beyond Node.js too.

## Using flake-utils for Multi-Platform Support

**User:** In the official guides I see they use flake-utils.url = "github:numtide/flake-utils" to support multiple systems but I didn't understand how to incorporate it in my config.

**Claude:** flake-utils is a helpful library that simplifies managing outputs for multiple systems. Here's how you can incorporate it into your config:

1. First, add it to your inputs:

```nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  nix-darwin.url = "github:nix-darwin/nix-darwin/master";
  nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  home-manager.url = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
  flake-utils.url = "github:numtide/flake-utils";
};
```

2. Then modify your outputs to use flake-utils:

```nix
outputs = inputs@{ self, nix-darwin, nix-homebrew, home-manager, nixpkgs, flake-utils, ... }:
  # Your existing host-specific darwin configuration
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake ~/.config/nix#mbp-16
    darwinConfigurations."mbp-16" = nix-darwin.lib.darwinSystem {
      modules = [
        # Your existing configuration...
      ];
    };
  }
  # Merge with flake-utils outputs for development shells
  // flake-utils.lib.eachDefaultSystem (system: 
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # Define development shells available on all platforms
      devShells = {
        nodejs16 = pkgs.mkShell {
          buildInputs = with pkgs; [ nodejs_16 ];
          shellHook = ''
            echo "Node.js $(node --version) development environment"
            echo "Use with direnv by adding 'use flake ~/.config/nix#nodejs16' to your .envrc file"
          '';
        };
        
        nodejs18 = pkgs.mkShell {
          buildInputs = with pkgs; [ nodejs_18 ];
          shellHook = ''
            echo "Node.js $(node --version) development environment"
            echo "Use with direnv by adding 'use flake ~/.config/nix#nodejs18' to your .envrc file"
          '';
        };
        
        nodejs20 = pkgs.mkShell {
          buildInputs = with pkgs; [ nodejs_20 ];
          shellHook = ''
            echo "Node.js $(node --version) development environment"
            echo "Use with direnv by adding 'use flake ~/.config/nix#nodejs20' to your .envrc file"
          '';
        };
      };
    }
  );
```

The key benefits of using flake-utils:

1. `eachDefaultSystem` automatically applies your configuration to all default systems (which includes x86_64-linux, aarch64-linux, x86_64-darwin, and aarch64-darwin)

2. You don't need to manually specify each system architecture

3. The code is more concise and maintainable

4. flake-utils provides other utilities for common patterns in Nix flakes

With this approach, your development shells would work on both macOS and Linux without additional configuration, which would be perfect for your future expansion to include your Linux server.

## Restructuring the Configuration

**User:** Before I start adding systems, I think it's gonna be prudent to split my configuration into several files for better separation of concerns and future proofing for adding more systems. Can you suggest a structure that adheres to best practices?

**Claude:** A well-structured Nix configuration makes a huge difference when managing multiple systems. Here's a directory structure that follows best practices:

```
~/.config/nix/
├── flake.nix           # Main entry point with minimal code
├── flake.lock          # Lock file (automatically managed)
├── hosts/              # Host-specific configurations
│   ├── common.nix      # Shared settings across all hosts
│   ├── mbp-16.nix      # macOS-specific config for your MacBook
│   └── server.nix      # Future Linux server config
├── modules/            # Reusable configuration modules
│   ├── packages.nix    # Package definitions (shared, platform-specific)
│   ├── homebrew.nix    # macOS homebrew configuration
│   └── services.nix    # Service configurations
└── devshells/          # Development environments
    ├── default.nix     # Main devShells module
    └── node.nix        # Node.js devShells
```

Your main flake.nix would then import these modules rather than containing everything directly. This structure offers:

1. Better organization by purpose
2. Easier maintenance when adding new systems
3. Clear separation between host-specific and shared configs
4. Focused files for different aspects of your setup

I helped restructure your configuration following this pattern, where:

- `modules/packages.nix` contains shared packages across systems
- `modules/homebrew.nix` handles macOS-specific homebrew configuration
- `hosts/common.nix` has settings common to all systems
- `hosts/mbp-16.nix` has MacBook-specific settings 
- `devshells/node.nix` defines Node.js development environments
- `flake.nix` ties everything together

The main flake.nix imports all these modules and makes them available as outputs.

## Custom Font Integration

**User:** I have a custom font I've built that I use in macOS for my terminals (ghostty, etc.). How do I bundle this font into a flake and automatically add it to macOS when I run darwin-rebuild?

**Claude:** To bundle a custom font into your flake and have it automatically added to macOS when you run darwin-rebuild, you can follow this approach:

1. **Create a font module in your configuration**:
   - Make a new file like `modules/fonts.nix`
   - This module would handle font installation

2. **Approach for font installation in macOS**:

   ```nix
   # This would go in modules/fonts.nix
   { pkgs, ... }:
   {
     # Method 1: For fonts that exist in nixpkgs
     fonts.fonts = with pkgs; [
       # nixpkgs fonts
     ];

     # Method 2: For custom fonts
     system.activationScripts.extraActivation.text = ''
       # Create user fonts directory if it doesn't exist
       mkdir -p ~/Library/Fonts
       
       # Copy your custom font from the Nix store to the user's font directory
       cp -f ${./path/to/your/custom-font.ttf} ~/Library/Fonts/
     '';
   }
   ```

**User:** I do believe I built my font with fontconfig but it was a long time ago. I use a custom version of Iosevka Term with ligatures enabled. Should I go that route or just copy the already built font to a folder and follow your instructions?

**Claude:** For a custom Iosevka build with ligatures, you have two good options:

1. **Simple approach (least resistance)**: 
   - Copy your already built font files to a folder in your Nix configuration
   - Use the activation script to install them to ~/Library/Fonts
   - This is quick and guaranteed to work with your existing files

2. **Nix-native approach (more reproducible)**:
   - Create a derivation that uses the Iosevka build process 
   - This would use the same configuration you used previously to build your custom variant
   - The advantage is fully reproducible builds - you could recreate the exact same font on any system

Since you already have your custom Iosevka built and working, I'd recommend the first approach initially. You can place your .ttf/.otf files somewhere like `~/.config/nix/assets/fonts/` and reference them in the activation script.

**User:** The good thing is, I found the build-plans.toml I used to build my custom Iosevka font. Now I need to figure out how to add them to the nix config.

**Claude:** That's great news that you have your build-plans.toml! Having that file makes the Nix-native approach much more feasible. Here's how you could incorporate your custom Iosevka build into your Nix configuration:

```nix
# This would go in a new file like modules/custom-iosevka.nix
{ pkgs, lib, ... }:

let
  customIosevka = pkgs.iosevka.override {
    set = "custom"; # Name of your font variant
    privateBuildPlan = builtins.readFile ../assets/iosevka/build-plans.toml;
    # You can also specify which weights/variants to build
    # For example: weights = ["regular" "bold"];
    # styles = ["normal" "italic"];
  };
in
{
  # For Darwin/macOS
  fonts.fonts = [ customIosevka ];
  
  # Alternatively, use an activation script if the fonts module doesn't work
  system.activationScripts.postUserActivation.text = ''
    echo "Installing custom Iosevka font..."
    mkdir -p ~/Library/Fonts
    
    # The path will depend on how the derivation structures its outputs
    for font in ${customIosevka}/share/fonts/truetype/*.ttf; do
      cp -f "$font" ~/Library/Fonts/
    done
  '';
}
```

The `iosevka.override` approach leverages Nixpkgs' existing Iosevka package but customizes it with your specific configuration. This is very powerful because:

1. It's fully reproducible
2. You don't need to store the font files, just the configuration
3. If you upgrade Nixpkgs, you'll get any improvements to the Iosevka build process

To check if your build-plans.toml is compatible with the current Iosevka version in Nixpkgs, you can:

1. Check the Iosevka version: `nix-env -qa iosevka --json | jq .`
2. Compare with the [Iosevka GitHub repository](https://github.com/be5invis/Iosevka) documentation
3. Try building in a temporary shell: `nix-shell -p "(iosevka.override { set = \"test\"; privateBuildPlan = builtins.readFile /path/to/your/build-plans.toml; })"`

---

This document captures our conversation about setting up a Nix configuration with:
- Node.js development environments
- Multi-platform support with flake-utils
- A well-structured, modular configuration
- Custom font integration

Refer to the README.md file for a complete guide to the configuration structure and usage.