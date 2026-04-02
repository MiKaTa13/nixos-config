{pkgs, ...}: let
  my-nnn = pkgs.nnn.overrideAttrs (oldAttrs: {
    # local source
    # src = ./sources/nnn;

    # remote git source
    src = pkgs.fetchFromGitHub {
      owner = "jarun";
      repo = "nnn";
      rev = "f5f1d5037f5e1e7e480a5ba4bd496ca544647241";
      sha256 = "sha256-bSzsEQUeca2S0UEiwfsdIkUA40z5qy88AxV37JMUO6E=";
    };
    patches = [];
    makeFlags =
      oldAttrs.makeFlags
      ++ [
        "O_NERD=1"
        "O_GIT=1"
        "O_GITSTATUS=1"
      ];
  });
in {
  home.packages = [my-nnn];
}
