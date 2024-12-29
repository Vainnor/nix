{ ... }: {


  homebrew = {
    enable = true;

    brews = [
      # macOS packages
      "neovim"
      "yq"
      "swift"
      "ca-certificates"
      "terminal-notifier"
    ];

    taps = [
      "homebrew/services"
    ];

    casks = [
      "obsidian"
      "ghostty"
      "wireshark"
      "betterdisplay"
      "shottr"
      "font-sf-pro"
      "font-jetbrains-mono"
    ];
  };
}