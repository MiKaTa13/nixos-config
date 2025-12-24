{...}: {
  programs.ranger = {
    enable = true;
    aliases = {
      e = "edit";
      filter = "scout -prts";
      setl = "setlocal";
    };
    mappings = {
      xd = "delete %f";
    };
    settings = {
      draw_borders = "both";
      show_hidden = true;
      column_ratios = "1,3,3";
      confirm_on_delete = "never";
      scroll_offset = 8;
      unicode_ellipsis = true;
    };
  };
}
