{...}: {
  programs.neomutt = {
    enable = true;
    extraConfig = ''
      # Debug
      # set debug_level = 2
      # set debug_file = "~/.neomutt/neolog"

      bind index <mouse> noop
      # Load custom sources
      source "~/.neomutt/accounts/gmail.com" # deffaul mailbox.
      source "~/.neomutt/neomutt-colors"
      source "~/.neomutt/neomutt-sidebar"
      source "~/.neomutt/neomutt-gpgrc"

      set mailcap_path = "~/.neomutt/neomutt-mailcap"
      set tmpdir = "~/.neomutt/temp"
      set mark_old = no
      set move = no

      set charset = "utf-8"
      set sort_aux = last-date-received
      set sort = reverse-threads
      set date_format = "%T %d-%m-%y"
      set index_format = "%2C | %Z [%d] %-30.30F (%-4.4c) %s"
      set editor = "nvim +13 -c 'set nobackup'\
                              -c 'set noswapfile'\
                              -c 'set nowritebackup'\
                              -c 'set tw=72 ft=mail noautoindent'\
                              -c 'colorscheme shine'"
      set pager_index_lines = 10
      set pager_context = 3
      set pager_stop
      set menu_scroll
      set tilde

      set query_command = "notmuch search --format=text --output=files %s"


      # Header settings
      set edit_headers = yes

      # Ignore and unignore settings
      ignore *
      unignore date from reply-to mail-followup-to followup-to to x-original-to cc newsgroups subject user-agent x-mailer x-url x-face

      # Sidebar binds
      bind index,pager B sidebar-toggle-visible
      bind index,pager \cp sidebar-prev
      bind index,pager \cn sidebar-next
      bind index,pager \ci sidebar-open

      # General rebindings
      bind editor <Tab> complete-query
      bind index j next-entry
      bind index k previous-entry
      bind pager k previous-line
      bind attach <return> view-mailcap
      bind attach l view-mailcap
      bind editor <space> noop
      bind browser G bottom-page
      bind index G last-entry
      bind index g  noop
      bind index gg first-entry
      bind browser gg top-page
      bind pager,attach h exit
      bind pager j next-line
      bind pager l view-attachments
      bind index U undelete-message
      bind index L limit
      bind index l display-message
      bind index h noop
      bind index,pager H view-raw-message
      bind browser l select-entry
      bind index,pager,browser d half-down
      bind index,pager,browser u half-up
      bind index,pager s sync-mailbox
      bind index,pager R group-reply
      bind index r imap-fetch-mail
      bind editor <Tab> complete-query

      # Deletion
      #bind index D purge-message

      # Get new mails.
      macro index,pager <F3> "<shell-escape>offlineimap -o -u quiet<enter><refresh><enter>"

      # Swich mailboxes.
      # macro index,pager <F4> \
      #     '<sync-mailbox><enter-command>source ~/.neomutt/accounts/gmail.com<enter><change-folder>!<enter>;<check-stats>'
      # macro index,pager <F5> \
      #     '<sync-mailbox><enter-command>source ~/.neomutt/accounts/disroot.org<enter><change-folder>!<enter>;<check-stats>'

      # Add mail to addres book.
      macro index,pager a \
          "<pipe-message>abook --add-email-quiet<return>" \
          "Add this sender to Abook"

      macro browser h \
          "<change-dir><kill-line>..<enter>" \
          "Go to parent folder"

      macro index,pager \cb \
          "<pipe-message> urlscan<Enter>" \
          "Call urlscan to extract URLs from a message"

      macro attach,compose \cb \
          "<pipe-entry> urlscan<Enter>" \
          "Call urlscan to extract URLs from a message"

      macro index N \
          "<next-unread-mailbox><enter><next-new-then-unread><enter>" \
          "Go to new mail"

      # Header cache.
      set header_cache = "~/.neomutt/cache/headers"

      # Use high $read_inc for faster reading of cached maildirs
      folder-hook . "set read_inc=1000"

      # Timeout
      set timeout = 300

      # After $timeout seconds of inactivity.
      timeout-hook "exec sync-mailbox"
    '';
  };
}
