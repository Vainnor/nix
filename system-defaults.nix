{ ... }: {
  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/Applications/Arc.app"
      "/Applications/Ghostty.app"
      "/Applications/Discord.app"
      "${pkgs.code-cursor}/Cursor.app"
      "/System/Applications/Mail.app"
    ]
  };
}