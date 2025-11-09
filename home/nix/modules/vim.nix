{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      statix
      alejandra
      deadnix
      nixpkgs-fmt
      shfmt
    ];
  };

  programs = {
    vim = {
      enable = true;
      defaultEditor = false;

      # vim settings
      settings = {
        background = "dark";
        expandtab = true;
        history = 1000;
        ignorecase = true;
        number = true;
        relativenumber = true;
        shiftwidth = 4;
        smartcase = true;
        tabstop = 4;
        undodir = ["~/.vim/backup"];
        undofile = true;
      };

      # manually set any options not listed above
      extraConfig = ''
        filetype plugin on
        filetype indent on
        syntax on
        set cursorline
        set nobackup
        set scrolloff=10 " Do not let cursor scroll below or above N number of lines when scrolling.
        set nowrap
        set incsearch
        set showcmd
        set showmode
        set showmatch
        set hlsearch
        set wildmenu " Enable auto completion menu after pressing TAB.
        set wildmode=list:longest " Make wildmenu behave like similar to Bash completion.
        set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
        " set list " Indentation.
        " set listchars=multispace:\ \ ┆ " Indentation.
        source ~/.vim/keymaps.vim " Key-mapss.
        source ~/.vim/ale.vim " ALE
        colorscheme oceanic_material
      '';
    };
  };
}
