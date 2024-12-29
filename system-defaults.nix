{ inputs, pkgs, ... }: {
  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/Applications/Arc.app"
      "/Applications/Ghostty.app"
      "/Applications/Discord.app"
      "/Applications/Cursor.app"
    ];
  };
}