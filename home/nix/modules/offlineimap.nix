{
  config,
  pkgs,
  ...
}: let
  mailDir = "/mnt/hdd500/Mail";
  gmailAddress = "misha13kopta@gmail.com";
  gmailSecret = "gmail-acces.age";

  # Lambda functions for folder mapping
  remoteNameTrans = "lambda folder: {
      '[Gmail]/Drafts': 'Drafts', 
      '[Gmail]/Sent Mail': 'Sent', 
      '[Gmail]/Starred': 'Flagged', 
      '[Gmail]/Trash': 'Trash', 
      '[Gmail]/All Mail': 'Archive'
      }.get(folder, folder)";
  localNameTrans = "lambda folder: {
      'Drafts': '[Gmail]/Drafts',
      'Sent': '[Gmail]/Sent Mail', 
      'Flagged': '[Gmail]/Starred', 
      'Trash': '[Gmail]/Trash', 
      'Archive': '[Gmail]/All Mail'
      }.get(folder, folder)";
  folderFilter = "lambda folder: folder not in [
      '[Gmail]/Trash', 
      '[Gmail]/Important', 
      '[Gmail]/Spam']
      ";
in {
  programs.offlineimap = {
    enable = true;

    # Python file for password retrieval
    pythonFile = ''
      import subprocess

      def get_secret(secret):
          # Allow only safe filenames
          if not isinstance(secret, str):
              raise ValueError("Secret name must be a string")
          elif '..' in secret or '/' in secret or '\\' in secret:
              raise ValueError(f"Path traversal detected in secret name: {secret}")

          encrypted_secret_path = "/home/nix/.config/home-manager/secrets"
          result = subprocess.run(["agenix", "-d", secret],
                                  cwd=encrypted_secret_path,
                                  capture_output=True,
                                  text=True,
                                  check=True)
          return result.stdout.strip()
    '';

    extraConfig.general = {
      ui = "ttyui";
      fsync = "False";
    };
  };

  accounts.email.accounts.gmail = {
    primary = true;
    address = gmailAddress;
    userName = gmailAddress;
    maildir.path = mailDir;
    realName = " ";
    notmuch.enable = true;

    imap = {
      host = "imap.gmail.com";
      port = 993;
      tls = {
        enable = true;
        useStartTls = false;
      };
    };

    offlineimap = {
      enable = true;
      extraConfig = {
        remote = {
          maxconnections = 1;
          realdelete = "no";
          type = "Gmail";
          createfolders = "True";
          sslcacertfile = "/etc/ssl/certs/ca-bundle.crt";
          remotepasseval = "get_secret(\"${gmailSecret}\")";
          nametrans = remoteNameTrans;
          folderfilter = folderFilter;
        };

        local = {
          ssl = "yes";
          type = "Maildir";
          localfolders = mailDir;
          nametrans = localNameTrans;
        };

        account.postSyncHookCommand = "notmuch new";
      };
    };
  };
}
