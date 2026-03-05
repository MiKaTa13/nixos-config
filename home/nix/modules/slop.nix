{pkgs, ...}: let
  my-slop = pkgs.slop.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "naelstrof";
      repo = "slop";
      rev = "v7.7";
      hash = "sha256-oUvzkIGrUTLVLR9Jf//Wh7AmnaNS2JLC3vXWg+w5W6g=";
    };

    nativeBuildInputs =
      (oldAttrs.nativeBuildInputs or [])
      ++ [
        pkgs.cmake
        pkgs.gnumake
      ];

    buildInputs =
      (oldAttrs.buildInputs or [])
      ++ [
        pkgs.glm
        pkgs.glew
        pkgs.xorg.libX11
        pkgs.xorg.libXrender
        pkgs.xorg.libXext
      ];
  });
in {
  home.packages = [my-slop];
}
