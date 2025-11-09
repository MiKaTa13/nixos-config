{
  pkgs,
  lib,
  ...
}: {
  programs.firejail.enable = true;
  programs.firejail.wrappedBinaries = {
    mpv = {
      executable = "${lib.getBin pkgs.mpv}/bin/mpv";
      profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
    };
  };
}
