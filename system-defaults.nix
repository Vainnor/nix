{ inputs, pkgs, ... }: {
  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/Applications/Arc.app"
      "/Applications/Ghostty.app"
      "/Applications/Discord.app"
      "/Applications/Cursor.app"
    ];
    finder.FXPreferredViewStyle = "Nlsv";
    finder.AppleShowAllFiles = true;
    finder.NewWindowTarget = "Documents";
    finder.ShowPathbar = true;
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;
    trackpad.TrackpadThreeFingerDrag = true;
    WindowManager.EnableStandardClickToShowDesktop = true;
    WindowManager.StandardHideDesktopIcons = true;
  };
}