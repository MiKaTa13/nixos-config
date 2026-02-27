{pkgs, ...}: let
  my-st = pkgs.st.overrideAttrs {
    src = ./sources/st; # or use fetchFromGitHub
    patches = [
      # ./patches/st/st-custom.diff # local pacth
      (pkgs.fetchpatch {
        # scrollback
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
        hash = "sha256-ZypvRONAHS//wnZjivmqpWIqZlKTqAQ0Q8DhQpZVaqU=";
      })
      (pkgs.fetchpatch {
        # scrollback-mouse
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff";
        hash = "sha256-CuNJ5FdKmAtEjwbgKeBKPJTdEfJvIdmeSAphbz0u3Uk=";
      })
      (pkgs.fetchpatch {
        # scrollback-mouse-altscreen
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff";
        hash = "sha256-8oVLgbsYCfMhNEOGadb5DFajdDKPxwgf3P/4vOXfUFo=";
      })
      (pkgs.fetchpatch {
        # st-boxdraw
        url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
        hash = "sha256-WN/R6dPuw1eviHOvVVBw2VBSMDtfi1LCkXyX36EJKi4=";
      })
    ];
  };
in {
  home = {
    packages = [
      my-st
    ];
  };
}
