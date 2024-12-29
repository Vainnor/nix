# This line declares that this is a Nix function that takes three parameters:
# - config: contains the current Home Manager configuration
# - pkgs: contains all available Nix packages
# - inputs: contains flake inputs (if you're using flakes)
{ config, pkgs, inputs, ... }:

# This 'let' binding creates a local variable that inherits the mkOutOfStoreSymlink 
# function from config.lib.file (used for creating symlinks)
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in

# The main configuration set starts here
{
  # Specifies the username for Home Manager
  home.username = "vainnor";
  
  # Sets the home directory path
  home.homeDirectory = "/Users/vainnor";
  
  # Specifies the Home Manager state version. This helps with backwards compatibility
  # and should not be changed after initial setup
  home.stateVersion = "24.05";

  # Enables XDG Base Directory specification support
  xdg.enable = true;

  # List of packages to install. Currently empty
  home.packages = [
  ];

  # Adds directories to the PATH environment variable
  home.sessionPath = [
    "/Users/vainnor/.local/bin"
    "/Users/vainnor/.cargo/bin"
    "/Users/vainnor/.gem"
    "/Users/vainnor/.ghcup/bin/ghc"
    "/Users/vainnor/.anaconda"
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "vainnor";
    userEmail = "github@carsonberget.com";
  };

  # File management section. Currently has a commented out line for Neovim config
  home.file = {
    # ".config/nvim".source = "${inputs.neovim}";
  };

  # Sets environment variables
  home.sessionVariables = {
    EDITOR = "Neovim";
  };

  # Enables Home Manager itself
  programs.home-manager.enable = true;
}