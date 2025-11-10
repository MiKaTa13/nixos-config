import subprocess

def get_secret(secret):
    # Allow only safe filenames
    if not isinstance(secret, str):
        raise ValueError("Secret name must be a string")
    elif '..' in secret or '/' in secret or '\\' in secret:
        raise ValueError(f"Path traversal detected in secret name: {secret}")

    encrypted_secret_path = "secrets"
    result = subprocess.run(["agenix", "-d", secret],
                            cwd=encrypted_secret_path,
                            capture_output=True,
                            text=True,
                            check=True)
    return result.stdout.strip()

print(get_secret("gmail-acces.age"))
