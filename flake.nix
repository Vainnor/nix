# Main configuration file for nix-darwin setup on macOS
{
  description = "Vainnor's flake";

  # Dependencies and external sources needed for this configuration
  inputs = {
    # Main Nix package repository, using unstable channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    # nix-darwin for macOS system configuration
    nix-darwin.url = "github:LnL7/nix-darwin";
    # Ensure nix-darwin uses the same nixpkgs as defined above
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    # Home Manager for user environment management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # dotfiles = {
    #  url = "github:vainnor/dots";
    # flake = false;
    #}

    # Custom neovim configuration (non-flake repository)
    neovim = {
      url = "github:amulabeg/neovim";
      flake = false;
    };
  };

  # Main configuration output
  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, neovim, }:
  let
    # Base system configuration
    configuration = { pkgs, ... }: {
      # Allow proprietary software
      nixpkgs.config.allowUnfree = true;

      imports = [ 
        ./darwin-configuration.nix
        ./system-defaults.nix
        ];

      users.users.vainnor = {
          name = "vainnor";
          home = "/Users/vainnor";
        };

      services.nix-daemon.enable = true;
      programs.zsh.enable = true; # default shell on catalina

      # Enable flakes and nix-command features
      nix.settings.experimental-features = "nix-command flakes";

      # Track configuration version for potential future migrations
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      # Specify this is for Apple Silicon Mac
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Main system configuration for MacBook Pro
   
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [
          # Apply base system configuration
          configuration
          # Enable home-manager integration
          home-manager.darwinModules.home-manager
          {
            # Home Manager configuration
            home-manager.useGlobalPkgs = true;    # Use system-level packages
            home-manager.useUserPackages = true;  # Enable user package management
            home-manager.users.vainnor = import ./home.nix;  # User-specific config
            # Pass flake inputs to home-manager
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
    };
  };
}
