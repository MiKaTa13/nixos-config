{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      tmux
    ];
  };

  programs = {
    tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 40;
      focusEvents = true;
      historyLimit = 10000;
      keyMode = "vi";
      mouse = true;
      newSession = true;
      prefix = "C-a";
      terminal = "xterm-256color";
      extraConfig = "source ~/.tmux.conf.back";
    };
  };
}
