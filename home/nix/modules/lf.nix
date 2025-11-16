{pkgs, ...}: {
  programs.lf = {
    enable = true;
    previewer.source = pkgs.writeShellScript "pv.sh" ''
      file="$1"

      # Directories: list content
      if [ -d "$file" ]; then
          ls --group-directories-first --color=always "$file"
          exit 0
      fi

      mime="$(file --mime-type -Lb "$file")"

      if printf '%s' "$mime" | grep -q '^image/'; then
          chafa -f "$file"
          exit 0
      fi

      if [ "$mime" = "application/zip" ]; then
          unzip -l "$file"
          exit 0
      fi

      if printf '%s' "$mime" | grep -q '^text/'; then
          bat --style=plain --color=always "$file"
      else
          file "$file"
      fi
    '';
    settings = {
      drawbox = true;
      number = true;
      preview = true;
      ratios = [
        1
        1
        2
      ];
      tabstop = 4;
    };
    extraConfig = ''
      cmd open ''${{
        case $(file --mime-type $f -b) in
          image/vnd.djvu|application/pdf|application/octet-stream) setsid -f zathura $fx >/dev/null 2>&1 ;;
          text/*) $EDITOR $fx;;
          image/x-xcf|image/svg+xml) setsid -f gimp $f >/dev/null 2>&1 ;;
          image/*) nsxiv $f;;
          audio/*) mpv --audio-display=no $f ;;
          video/*) setsid -f mpv $f -quiet >/dev/null 2>&1 ;;
          application/pdf|application/vnd*|application/epub*) setsid -f zathura $fx >/dev/null 2>&1 ;;
          *) for f in $fx; do setsid -f $OPENER $f >/dev/null 2>&1; done;;
        esac
      }}
    map o open
    '';
  };
}
