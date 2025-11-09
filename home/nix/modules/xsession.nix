{ config, pkgs, ... }:

{
  xsession.enable = true;
  xsession.initExtra = ''
    xrdb -merge ~/.Xdefaults
    dwmblocks &
    picom &  # window compositor
    $HOME/.local/bin/auto-wallpaper.sh
    exec dwm
  '';
}

