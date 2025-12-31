{...}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
    };
    extraConfig = ''
      -o ~/Downloads/YouTube/%(title)s.%(ext)s
    '';
  };
}
