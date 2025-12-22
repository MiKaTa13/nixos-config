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
        grep = "grep --color=auto";
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

        # Color man
        export LESS_TERMCAP_mb=$'\e[1;32m'
        export LESS_TERMCAP_md=$'\e[1;32m'
        export LESS_TERMCAP_me=$'\e[0m'
        export LESS_TERMCAP_se=$'\e[0m'
        export LESS_TERMCAP_so=$'\e[01;33m'
        export LESS_TERMCAP_ue=$'\e[0m'
        export LESS_TERMCAP_us=$'\e[1;4;31m'

        # fzf
        source ~/.local/share/fzf/key-bindings.bash
        source ~/.local/share/fzf/completion.bash

        # Translate text from clipboard
        translate() {
          local model="hf.co/INSAIT-Institute/MamayLM-Gemma-3-12B-IT-v1.0-GGUF:Q4_K_M"
          local prompt="translate to Ukrainian"
          local clipboard
          clipboard=$(xclip -out -selection clipboard)
          echo -e "[$(echo -n "$clipboard" | wc -c) bytes]\n"
          ollama run $model "$prompt $clipboard"
        }
      '';
    };
  };
}
