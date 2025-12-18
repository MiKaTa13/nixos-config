let
  # My user key
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5IzfI3WJe4lgO91imm+3FV9SWcp2xvmpGmHaNKTROe nix@nixos";
in {
  "gdrive-token.age".publicKeys = [user];
  "gmail-acces.age".publicKeys = [user];
}
