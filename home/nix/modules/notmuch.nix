{...}: {
  programs.notmuch = {
    enable = true;
    extraConfig = {
      database = {
        path = "/mnt/hdd500/Mail";
      };
    };
    new = {
      tags = ["new" "unread"];
      ignore = [".mbsyncstate" ".uidvalidity"];
    };
    search = {
      excludeTags = ["deleted" "spam"];
    };
    hooks = {
      postNew = ''
        notmuch tag +inbox -new -- tag:new
        notmuch tag +sent -new -- from:misha13kopta@gmail.com
      '';
    };
  };
}
