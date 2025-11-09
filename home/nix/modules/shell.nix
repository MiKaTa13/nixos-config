{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      bash
    ];
  };

  programs = {
    bash = {
      enable = true;
      # aliases.
      shellAliases = {
        l = "ls";
        ll = "ls -l";
        la = "ls -la";
        ".." = "cd ..";
        cp = "cp -v";
        df = "df -h";
        du = "du -h";
        year = "cal -mwy";
        fcd = "cd $(find . -type d | fzf --reverse)";
      };
      shellOptions = [
        "histappend"
        "checkwinsize"
        "extglob"
        "globstar"
        "checkjobs"
      ];
      initExtra = ''
        # PATH
        PATH=$PATH:$HOME/.local/bin

        # GIT prompt.
        source "$HOME/.local/share/bash/git-prompt.sh"
        GIT_PS1_SHOWCOLORHINTS=1
        GIT_PS1_SHOWDIRTYSTATE=1
        GIT_PS1_SHOWSTASHSTATE=1
        GIT_PS1_SHOWUNTRACKEDFILES=1
        GIT_PS1_SHOWUPSTREAM="auto"
        # Custom PS1 prompt
        PS1='\[\033[37m\][\u@\h \[\033[36m\]\w\[\033[37m\]]\[\033[0m\]$(__git_ps1 " (%s)")\$ '

        # quemu on ssh.
        # export QEMU_OPTS='-nographic'

        # fzf
        source ~/.local/share/fzf/key-bindings.bash
        source ~/.local/share/fzf/completion.bash
      '';
    };
  };
}
