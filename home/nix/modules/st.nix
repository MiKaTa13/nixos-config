{pkgs, ...}: let
  my-st = pkgs.st.overrideAttrs {
    src = /home/nix/.local/src/st; # or use fetchFromGitHub
    patches = [
      ../patches/st/st-custom.diff
      (pkgs.fetchpatch {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
        hash = "sha256-ZypvRONAHS//wnZjivmqpWIqZlKTqAQ0Q8DhQpZVaqU=";
      })
      (pkgs.fetchpatch {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff";
        hash = "sha256-CuNJ5FdKmAtEjwbgKeBKPJTdEfJvIdmeSAphbz0u3Uk=";
      })
      (pkgs.fetchpatch {
        url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20220127-2c5edf2.diff";
        hash = "sha256-8oVLgbsYCfMhNEOGadb5DFajdDKPxwgf3P/4vOXfUFo=";
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
