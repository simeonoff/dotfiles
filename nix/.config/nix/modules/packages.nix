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
    iosevka
    sesh
    starship
    yq-go
  ];
}

