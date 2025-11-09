{config, ...}: {
  programs.git = {
    enable = true;
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
      ca= "!(git commit -m \"$(git diff --cached | auto-commit)\" && git log --stat -1)"; # write commits with local llm.
    };
  };
}
