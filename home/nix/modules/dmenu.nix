{pkgs, ...}: let
  my-dmenu = pkgs.dmenu.overrideAttrs {
    src = pkgs.fetchgit {
      url = "https://git.suckless.org/dmenu";
      rev = "7175c4880bac3d2a2d4a6262b59193f0a38e2fdb"; #  git ls-remote https://git.suckless.org/dmenu HEAD
      hash = "sha256-4B+0oDQPeCm4ljjCrpeiz0pFGKZlU9sXneVplkNkI/0=";
    };
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
  home.packages = [my-dmenu];
}
