{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    ./homebrew.nix
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      vainnor = import ./home.nix;
    };
  };

  environment.systemPackages = with pkgs; [
    man
    mkalias
    # Neovim tools
    nushell
    ani-cli
    vim
    ripgrep
    # Terminal tools
    stow
    luajitPackages.jsregexp
    git
    zsh
    fd
    neofetch
    fzf
    zoxide
    tmux
    gnused
    sesh
    bat
    eza
    curl
    cmatrix
    cowsay
    fastfetch
    gh
    ffmpeg
    fish
    gnugrep
    htop
    lazydocker
    lazygit
    lsd
    llvm
    nerdfix
    netcat
    qemu
    ranger
    starship
    tldr
    tree
    unzip
    luarocks
    wget
    yazi
    yt-dlp
    ultralist
    home-manager
    docker
    btop
    # TWM tools 
    skhd
    yabai
    # Compilers
    gcc-arm-embedded
    cmake
    python3
    go
    gnumake
    openjdk
    cargo
    rustc
    nodejs
    yarn
    php
    julia_19-bin
    # SQL tools
    sqlite
    postgresql
    duckdb

    # Formatters
    clang-tools
    fontconfig

    poetry
    vscodium


    # Cool stuff
  ];

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
    # Set up applications.
    echo "setting up /Applications..." >&2
    rm -rf /Applications/Nix\ Apps
    mkdir -p /Applications/Nix\ Apps
    find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
    while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
    done
        '';

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.warn-dirty = false;

  homebrew.onActivation.cleanup = "zap";
  nix.settings.experimental-features = lib.mkForce [ "nix-command" "flakes" ];
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  programs.zsh.enable = true; # default shell on catalina
  system.stateVersion = 5;
}