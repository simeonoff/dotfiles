# Common packages for all systems
{ pkgs, ... }:

{
  # Allow non-foss packages
  nixpkgs.config.allowUnfree = true;

  # Shared packages that work across Linux and macOS
  environment.systemPackages = with pkgs; [
    # CLI Tools
    bat
    curl
    eza
    fd
    fzf
    jq
    mosh
    openssl
    ripgrep
    silver-searcher
    stow
    tmux
    tree
    wget
    xz

    # Development
    cmake
    git
    go
    just
    lazygit
    neovim
    nodePackages_latest.nodejs
    python313
    python313Packages.west
    wezterm

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
    pkg-config
    sesh
    yq-go
  ];
}

