{config, ...}: {
  age = {
    # SSH private key for decryption
    identityPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];

    # Declare secrets
    secrets = {
      gdrive-token = {
        file = ../secrets/gdrive-token.age; # Path to encrypted file
      };
    };
  };
}
