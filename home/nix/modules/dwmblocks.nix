{pkgs, ...}: let
  my-dwmblocks = pkgs.dwmblocks.overrideAttrs {
    # remote github source
    src = pkgs.fetchFromGitHub {
      owner = "torrinfail";
      repo = "dwmblocks";
      rev = "8cedd220684064f1433749ed2a19a6184c22cf07"; # git ls-remote https://github.com/torrinfail/dwmblocks  HEAD
      sha256 = "sha256-QtYQB2mvw1k2LA8D+/cVnA8+GRDWjhIM6rxfi/IGjEw=";
    };

    patches = [];
  };
in {
  home.packages = [my-dwmblocks];
}
