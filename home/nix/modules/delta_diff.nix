{...}: {
  # diff viever for git
  programs.delta = {
    # diff viever
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true; # Use n and N to move between diff sections
      light = false; # Set to true for light terminal backgrounds
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "Nord";
    };
  };
}
