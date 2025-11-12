{...}: {
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#000000";
      default-fg = "#FFFFFF";
      selection-clipboard = "clipboard";
    };
    mappings = {
      "<Right>" = "navigate next";
      D = "toggle_page_mode";
      "[fullscreen] <C-i>" = "zoom in";
    };
  };
}
