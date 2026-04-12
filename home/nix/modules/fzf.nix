{pkgs, ...}: let
  my-fzf = pkgs.fzf.overrideAttrs (oldAttrs: {
    # remote github source
    version = "0.71.0";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "fzf";
      rev = "v0.71.0";
      hash = "sha256-fEHNE51VTggSwNutefCg/WueaXRE1J0D/dyVPFqhTJg=";
    };
  });
in {
  home.packages = [my-fzf];
}
