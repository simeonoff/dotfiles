# Common packages for all systems
{ pkgs, ... }:

{
  # Allow non-foss packages
  nixpkgs.config.allowUnfree = true;

  # Shared packages that work across Linux and macOS
  environment.systemPackages = with pkgs; [
    # CLI Tools
    bash
    direnv
    fd
    fzf
    ripgrep
    silver-searcher
    stow
    tmux
    tree
    wget
    xz
    zoxide

    # Development
    git
    go
    just
    lazygit
    neovim
    nodejs_22
    python313
    python313Packages.west

    # Languages and Runtimes
    dart-sass
    docfx
    dotnet-sdk_9
    lua5_4_compat
    lua54Packages.luarocks
    luajit
    tree-sitter

    # Other tools
    _1password-cli
    sesh
    starship
    yq-go
  ];
}

