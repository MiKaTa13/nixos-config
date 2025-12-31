{pkgs, ...}: {
  home.packages = [
    (pkgs.python313.withPackages (ps:
      with ps; [
        requests
        black
        isort
        ruff
      ]))
  ];
}
