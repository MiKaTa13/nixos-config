{...}: {
  programs.ranger = {
    enable = true;
    settings = {
      draw_borders = "both";
      show_hidden = true;
    };
  };
}
