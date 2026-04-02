{pkgs, ...}: let
  my-dwm = pkgs.dwm.overrideAttrs (oldAttrs: {
    # local source
    # src = ./sources/dwm;

    # remote git source
    src = pkgs.fetchgit {
      url = "https://git.suckless.org/dwm";
      rev = "44dbc6809d05b8f2addc483f882e670db0b6b8e9"; # commit hash.
      hash = "sha256-+arHEGdhEL9fWn7eYE+A82jc/jsje8e2hgRDbJRK8Pk=";
    };
    patches =
      (oldAttrs.patches or [])
      ++ [
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
  });
in {
  home.packages = [my-dwm];
}
