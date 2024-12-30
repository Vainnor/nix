{
  pkgs,
  outputs,
  userConfig,
  config,
  ...
}: {
  
  # Add nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${userConfig.name}";
    autoMigrate = true;
  };

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  nix.package = pkgs.nix;

  # Enable Nix daemon
  services.nix-daemon.enable = true;

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # Add ability to use TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # System settings
  system = {
    defaults = {
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = -1.0;
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        PMPrintingExpandedStateForPrint = true;
      };
      WindowManager = {
        StandardHideDesktopIcons = true;
        EnableStandardClickToShowDesktop = true;
      };
      LaunchServices = {
        LSQuarantine = false;
      };
      trackpad = {
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        Clicking = true;
      };
      finder = {
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      dock = {
        autohide = true;
        expose-animation-duration = 0.15;
        show-recents = false;
        showhidden = true;
        persistent-apps = [
          "/Applications/Arc.app"
          "/Applications/Ghostty.app"
          "/Applications/Discord.app"
          "/Applications/Cursor.app"
        ];
        tilesize = 30;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      screencapture = {
        location = "/Users/${userConfig.name}/Downloads/temp";
        type = "png";
        disable-shadow = true;
      };
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [pip virtualenv]))
    awscli2
    colima
    delta
    docker
    du-dust
    eza
    fd
    jq
    kubectl
    lazydocker
    nh
    openconnect
    pipenv
    ripgrep
    terraform
    terragrunt

    # Vainnors
    rustc
    cargo
    nodejs
    python3
    cmake
    zoxide

    mkalias
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

  # Zsh configuration
  programs.zsh.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    roboto
  ];

  homebrew = {
    enable = true;
    brews = [
      "yq"
      "swift"
      "ca-certificates"
      "terminal-notifier"
    ];
    casks = [
      "hiddenbar"
      "obsidian"
      "ghostty"
      "wireshark"
      "betterdisplay"
      "shottr"
      "font-sf-pro"
      "font-jetbrains-mono"
      "raycast"
    ];
    taps = [
      
    ];
    onActivation.cleanup = "zap";
  };
  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
