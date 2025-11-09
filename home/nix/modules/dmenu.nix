{pkgs, ...}: let
  my-dmenu = pkgs.dmenu.overrideAttrs {
    src = ./sources/dmenu; # or use fetchFromGitHub
    patches = [
      # ./sources/patches/dwm/dwm-custom.diff
      (pkgs.fetchpatch {
        url = "https://tools.suckless.org/dmenu/patches/xyw/dmenu-xyw-5.2.diff";
        hash = "sha256-Mbb88NLOEHIOLvfbXZLT4pQ3JENZUQ8COvz25MkaUlo=";
      })
      (pkgs.fetchpatch {
        url = "https://tools.suckless.org/dmenu/patches/border/dmenu-border-20230512-0fe460d.diff";
        hash = "sha256-huyZHf+deY4vNwwgBAXRRKhZ0UrxWuBrtpVUe604zb4=";
      })
    ];
  };
in {
  home = {
    packages = with pkgs; [
      my-dmenu
    ];
  };
}
