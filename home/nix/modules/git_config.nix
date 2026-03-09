{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "fox-on-nix";
        email = "nix@nomail.com";
      };
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
      core.hooksPath = "~/.git-hooks"; # Uncoment to add hoooks
      core.editor = "nvim";
      # safe.directory = "/home/nix/.dotfiles";
      alias = {
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
  };
}
