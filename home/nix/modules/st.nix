{pkgs, ...}: let
  my-st = pkgs.st.overrideAttrs (oldAttrs: {
    # local source
    # src = ./path-to-sources/st;

    # remote git source
    src = pkgs.fetchgit {
      url = "https://git.suckless.org/st";
      rev = "688f70add0d1da8a416bf7df763328d694a24a3a"; # git ls-remote https://git.suckless.org/st HEAD
      hash = "sha256-PUMhcvPy63G9qQ3S8kTBLXf4RmPlPDRA61c35tspBu4=";
    };

    patches =
      (oldAttrs.patches or [])
      ++ [
        ./patches/st/st-custom.diff # local pacth
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
        (pkgs.fetchpatch {
          # st-glyph-wide-support
          url = "https://st.suckless.org/patches/glyph_wide_support/st-glyph-wide-support-boxdraw-20220411-ef05519.diff";
          hash = "sha256-MtOFgi8W8SOaj/NpZAg8IGCOR6e3JnfxWw7COVO0RkU=";
        })
      ];
  });
in {
  home.packages = [my-st];
}
