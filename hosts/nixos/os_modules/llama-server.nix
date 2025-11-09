{
  # config,
  pkgs,
  ...
}:
# systemctl status llama_cpp.service
# journalctl -u llama_cpp.service -f
# systemd-analyze security llama.cpp
let
  llamaUser = "llama";
  llamaGroup = "llama";
  modelDir = "/var/lib/llama"; # Put models here.
  llamaExecutable = "/opt/llama.cpp/build/bin/llama-server"; # replace with actual path
in {
  users.groups.llama = {};

  # Create dedicated system user without a home directory
  users.users."${llamaUser}" = {
    isSystemUser = true;
    description = "Dedicated user for llama.cpp service";
    group = "${llamaGroup}"; # primary group
    createHome = false;
    shell = "${pkgs.util-linux}/bin/nologin"; # non login user.
  };

  # Define the systemd service
  systemd.services.llama_cpp = {
    description = "llama.cpp server";

    # Start after network is ready (ordering, not dependency)
    after = ["network.target"];
    # Soft dependency: make sure network service is started before this service
    wants = ["network.target"];
    # Ensure this service is automatically started when the system reaches
    # multi-user mode (standard server mode). This creates a soft link so
    # systemd will start llama_cpp on boot without requiring manual start.
    wantedBy = ["multi-user.target"];

    # Command or script to run the service
    script = ''
      exec ${llamaExecutable} --model ${modelDir}/ggml-org_gemma-3-1b-it-GGUF_gemma-3-1b-it-Q4_K_M.gguf \
        --no-webui --host 0.0.0.0
    '';

    serviceConfig = {
      User = "${llamaUser}";
      Group = "${llamaGroup}";
      StandardOutput = "journal"; # send stdout to journal
      StandardError = "journal"; # send stderr to journal
      PrivateTmp = true; # Own /tmp, not shared with system
      ProtectSystem = "strict"; # Read-only /usr, /boot, /etc (set to "full" or "strict")
      NoNewPrivileges = true; # Prevent gaining extra privileges
      PrivateDevices = true; # No access to host devices
      ProtectKernelModules = true; # No access to /lib/modules
      ProtectKernelTunables = true; # No access to kernel tunables
      ProtectControlGroups = true; # No access to cgroupfs
      #RestrictAddressFamilies = [ "AF_UNIX" ]; # Limit allowed network families
      CapabilityBoundingSet = ""; # Drop all Linux capabilities
      ProtectProc = "invisible"; # Hide details of other processes
      MemoryDenyWriteExecute = true; # Block W+X memory regions
      #SystemCallFilter = "~@privileged @resources";
      Environment = "LD_LIBRARY_PATH=/opt/llama.cpp/build/bin"; # Additional libraris.
      # Optional: restart automatically on failure
      Restart = "always";
      RestartSec = 5;
    };
  };
}
