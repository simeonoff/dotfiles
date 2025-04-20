# Nix Configuration

This guide explains the structure and purpose of this Nix configuration, designed for simplicity and flexibility.

## Overview

This is a modular Nix configuration that:
- Manages system packages and settings
- Provides development environments
- Is organized to support multiple systems

## Directory Structure

```
~/.config/nix/
├── flake.nix           # Main entry point
├── flake.lock          # Lock file (automatically generated)
├── hosts/              # Host-specific configurations
│   ├── common.nix      # Shared settings across all hosts
│   ├── mbp-16.nix      # macOS-specific config
│   └── shinobi.nix     # Future Linux server config
├── modules/            # Reusable configuration modules
│   ├── packages.nix    # Package definitions
│   ├── homebrew.nix    # macOS homebrew configuration
│   ├── system.nix      # System configuration (Git revision)
│   └── services.nix    # Service configurations
└── devshells/          # Development environments
    ├── default.nix     # Main devShells module
    └── node.nix        # Node.js devShells
```

## How It Works

### Main Components

1. **flake.nix**: The entry point that ties everything together
   - Defines inputs (dependencies from GitHub)
   - Configures outputs (system configurations and dev shells)
   - Uses flake-utils to handle multiple platforms

2. **hosts/**: Contains configurations for specific computers
   - `common.nix`: Settings shared across all systems
   - `mbp-16.nix`: MacBook Pro specific settings
   - `shinobi.nix`: For future Linux server

3. **modules/**: Reusable configuration components
   - `packages.nix`: Defines software to install
   - `homebrew.nix`: macOS-specific package management
   - `system.nix`: System configuration settings
   - `services.nix`: Service definitions

4. **devshells/**: Development environments that work on any system
   - `default.nix`: Combines all development shells
   - `node.nix`: Node.js environments with different versions

### Common Tasks

#### Rebuilding Your System

Update your MacBook's configuration:
```bash
darwin-rebuild switch --flake ~/.config/nix#mbp-16
```

#### Using Development Environments

Launch a Node.js 20 environment:
```bash
nix develop ~/.config/nix#nodejs20
```

Use with direnv in a project:
1. Add to your project's `.envrc` file:
   ```
   use flake ~/.config/nix#nodejs20
   ```
2. Run `direnv allow` in the project directory

## How Everything Is Connected

1. **Configuration Flow**:
   - `flake.nix` loads the host configurations
   - Host config imports common settings and modules
   - Modules define packages, services, and system settings

2. **Development Environments**:
   - Defined in `devshells/` directory
   - Made available via flake-utils across all systems
   - Accessible through `nix develop` or direnv

3. **Adding Packages**:
   - System-wide packages: Add to `modules/packages.nix`
   - macOS-specific: Add to `hosts/mbp-16.nix`
   - Homebrew packages: Add to `modules/homebrew.nix`

## Extending The Configuration

### Adding New Packages

Edit `modules/packages.nix` and add to the list:
```nix
environment.systemPackages = with pkgs; [
  # Existing packages
  my-new-package
];
```

### Adding a New Development Shell

1. Edit `devshells/node.nix` or create a new file
2. Import it in `devshells/default.nix`

### Adding Linux Server Configuration

1. Create/edit `hosts/shinobi.nix` for your server
2. Add this to `flake.nix`:
```nix
nixosConfigurations."shinobi" = nixpkgs.lib.nixosSystem {
  specialArgs = { inherit self; };
  modules = [
    ./hosts/common.nix
    ./modules/packages.nix
    ./modules/system.nix
    ./hosts/shinobi.nix
    # Other modules as needed
  ];
};
```
3. Deploy with `nixos-rebuild switch --flake ~/.config/nix#shinobi`
