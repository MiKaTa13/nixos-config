{lib, ...}: {
  programs.qutebrowser = {
    enable = true;

    loadAutoconfig = false; # Load settings configured via the GUI.

    extraConfig = ''
      config.set('editor.command', ['xterm', '-e', 'nvim', '{file}'])
      config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:136.0) Gecko/20100101 Firefox/139.0', 'https://accounts.google.com/*')
      c.input.insert_mode.auto_load = True
      c.prompt.filebrowser = False
      c.completion.height = "30%"
      c.completion.web_history.max_items = 1000
      c.input.partial_timeout = 2000
      c.tabs.background = True
      c.tabs.favicons.show = "always"
      c.tabs.title.format = "{index}.{current_title}"
      c.tabs.new_position.related = "last"
      c.downloads.location.directory = '/home/nix/Downloads'
      c.content.cache.size = 52428800
      c.content.webgl = False
      c.content.autoplay = False
      c.content.geolocation = False
      c.content.blocking.enabled = True
      c.content.blocking.method = "both"
      c.content.notifications.enabled = False
      c.content.tls.certificate_errors = "ask-block-thirdparty"
      c.hints.border = "1px solid #CCCCCC"
      c.hints.mode = "number"
      c.hints.chars = "123456789"
      c.hints.min_chars = 1
      c.keyhint.blacklist = ["*"]
      c.completion.open_categories = ["quickmarks", "history"]
      c.statusbar.widgets = ["url", "progress", "scroll"]
      c.zoom.default = "100%"
      c.scrolling.bar = "when-searching"
      c.tabs.padding = {'bottom': 3, 'left': 0, 'right': 0, 'top': 3}
      # fonts
      c.fonts.default_family = ["Droid Sans Mono", "DejaVu Sans Mono", "Liberation Mono"]
      c.fonts.tabs.selected = "8pt Droid Sans Mono"
      c.fonts.tabs.unselected = c.fonts.tabs.selected
      c.fonts.statusbar = "8pt Droid Sans Mono"
      c.fonts.downloads = c.fonts.statusbar 
      c.fonts.prompts = c.fonts.statusbar
      c.fonts.hints = "9px Droid Sans Mono"
      c.fonts.messages.info = "8pt Droid Sans Mono"
      c.fonts.keyhint = c.fonts.messages.info
      c.fonts.messages.warning = c.fonts.messages.info
      c.fonts.messages.error = c.fonts.messages.info
      c.fonts.completion.entry = c.fonts.statusbar
      c.fonts.completion.category = c.fonts.statusbar
    '';

    settings = {
      colors = {
        hints = {
          bg = "#000000";
          fg = "#ffffff";
        };
        tabs.bar.bg = "#000000";
      };
      tabs.tabs_are_windows = false;
    };

    aliases = {
      ge = "open -t https://wiki.archlinux.org/index.php/Forum_Etiquette";
    };

    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      ns = "https://home-manager-options.extranix.com/?query={}&release=release-25.05";
      g = "https://www.google.com/search?hl=en&q={}";
    };

    quickmarks = {
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      home-manager = "https://github.com/nix-community/home-manager";
    };

    keyBindings = {
      normal = {
        "<Ctrl-v>" = "spawn mpv {url}";
        ",p" = "spawn --userscript qute-pass";
        ",l" = ''config-cycle spellcheck.languages ["en-GB"] ["en-US"]'';
        "<F1>" = lib.mkMerge [
          "config-cycle tabs.show never always"
          "config-cycle statusbar.show in-mode always"
          "config-cycle scrolling.bar never always"
        ];
      };

      prompt = {
        "<Ctrl-y>" = "prompt-yes";
      };
    };
  };
}
