{...}: {
  xsession.enable = true;
  xsession.initExtra = ''
    xrdb -merge ~/.Xdefaults
    dwmblocks &
    $HOME/.local/bin/auto-wallpaper.sh
    exec dwm
  '';
}
