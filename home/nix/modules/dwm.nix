{pkgs, ...}: let
  my-dwm = pkgs.dwm.overrideAttrs {
    src = ./sources/dwm;
    patches = [
      ./patches/dwm/dwm-custom.diff
      (pkgs.fetchpatch {
        url = "https://dwm.suckless.org/patches/azerty/dwm-azerty-6.2.diff";
        hash = "sha256-dDRI2rIc+q3xNsBZqlvfEJt/C5IRN+NV1V477h99FIM=";
      })
      (pkgs.fetchpatch {
        url = "https://dwm.suckless.org/patches/vanitygaps/dwm-cfacts-vanitygaps-6.4_combo.diff";
        hash = "sha256-i/lvTKDXdUrtxpx0epBUz+FSSlO2M+CJu/8SFr2wbG0=";
      })
    ];
  };
in {
  home.packages = [my-dwm];
}
