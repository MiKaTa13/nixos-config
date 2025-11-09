let
  # My user key
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5IzfI3WJe4lgO91imm+3FV9SWcp2xvmpGmHaNKTROe nix@nixos";
  # System host key (for NixOS)
  # system = "ssh-ed25519 AAAAC3Nza... root@hostname";

  # All keys that can decrypt
  allKeys = [user];
in {
  "gdrive-token.age".publicKeys = [user];
  "gmail-acces.age".publicKeys = [user];
  # "api-token.age".publicKeys = allKeys;
  # "github-token.age".publicKeys = [ user ];  # Only accessible by user
}
