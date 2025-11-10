{
  config,
  pkgs,
  ...
}: {
  programs.lf = {
    enable = true;
    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/bin/sh

      case "$1" in
          *.tar*) tar tf "$1";;
          *.zip) unzip -l "$1";;
          *.rar) unrar l "$1";;
          *.7z) 7z l "$1";;
          *) highlight -O ansi "$1" || cat "$1";;
      esac
    '';
    settings = {
      drawbox = true;
      number = true;
      ratios = [
        1
        1
        2
      ];
      tabstop = 4;
    };
  };
}
