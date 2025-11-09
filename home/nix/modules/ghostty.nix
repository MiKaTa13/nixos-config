{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = false;
    settings = {
      theme = "catppuccin-mocha";
      window-decoration = "server"; # Server-side decorations
      window-padding-x = "2,4";
      window-padding-y = "2,4";
      window-padding-balance = true;
      font-size = 11;
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title";
      background-opacity = 1;
      unfocused-split-opacity = 0.7;
      # clipboard protection
      clipboard-read = "ask"; # prompts before programs read clipboard
      clipboard-write = "allow"; # allows writing to clipboard
      clipboard-paste-protection = true; # warns about dangerous pastes (e.g., commands with newlines)
      copy-on-select = true; # auto-copy selection
      # prevent title query attacks
      title-report = false;
    };
    # See https://ghostty.org/docs/features/theme#authoring-a-custom-theme for more information.
     themes = {
       catppuccin-mocha = {
         background = "09090a";
         cursor-color = "f5e0dc";
         foreground = "cdd6f4";
    #     palette = [
    #       "0=#45475a"
    #       "1=#f38ba8"
    #       "2=#a6e3a1"
    #       "3=#f9e2af"
    #       "4=#89b4fa"
    #       "5=#f5c2e7"
    #       "6=#94e2d5"
    #       "7=#bac2de"
    #       "8=#585b70"
    #       "9=#f38ba8"
    #       "10=#a6e3a1"
    #       "11=#f9e2af"
    #       "12=#89b4fa"
    #       "13=#f5c2e7"
    #       "14=#94e2d5"
    #       "15=#a6adc8"
    #     ];
    #     selection-background = "353749";
    #     selection-foreground = "cdd6f4";
       };
     };
  };
}
