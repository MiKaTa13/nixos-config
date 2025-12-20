{pkgs, ...}: let
  my-dwmblocks = pkgs.dwmblocks.overrideAttrs {
    src = ./sources/dwmblocks; # or use fetchFromGitHub
    patches = [
      # ./sources/patches/patches/some-patch.diff
      # (pkgs.fetchpatch {
      #   url = "https://st.suckless.org/some/other/patch.diff";
      #   hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      # })
    ];
  };
in {
  home.packages = [my-dwmblocks];
}
