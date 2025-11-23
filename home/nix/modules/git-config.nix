{...}: {
  programs.git = {
    enable = true;
    delta = {
      # diff viever
      enable = true;
      options = {
        navigate = true; # Use n and N to move between diff sections
        light = false; # Set to true for light terminal backgrounds
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Nord";
      };
    };
    userEmail = "nix@nomail.com";
    userName = "fox-on-nix";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
      core.hooksPath = "~/.git-hooks";
      # safe.directory = "/home/nix/.dotfiles";
    };
    aliases = {
      ci = "commit";
      st = "status";
      co = "checkout";
      br = "branch";
      alias = "! git config --get-regexp ^alias\\. | sed -e s/^alias\\.// -e s/\\ /\\ =\\ /";
      sw = "switch";
      last = "log -1 HEAD";
      purge = "!git clean -df && git checkout -- .";
      wip = "'!f() { git add -A && git commit -m \"WIP\"; }; f'";
      unwip = "reset HEAD~1";
      ca = "!(git commit -m \"$(~/.local/bin/auto-commit.py)\" && git log --stat -1)"; # write commits with local llm.
    };
  };
}
