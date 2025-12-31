{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dimensions = {
          lines = 3;
          columns = 200;
        };
        dynamic_padding = true;
        decorations = "None";
      };
      keyboard.bindings = [
        {
          key = "K";
          mods = "Control";
          chars = "\\u000c";
        }
      ];
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        unfocused_hollow = true;
      };
      mouse = {
        hide_when_typing = true;
      };
      font = {
        size = 11.28;
        builtin_box_drawing = true;
      };
    };
    # theme = "rose_pine";
    theme = "tokyo_night";
  };
}
