{...}: {
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda"; # null - for disable.
      environmentVariables = {
        # Use custom model directory
        OLLAMA_MODELS = "/mnt/data2/OllamaModels";

        # Limit parallelism to number of physical cores to avoid hyperthreading inefficiency
        OLLAMA_NUM_PARALLEL = "8";

        # Reduce max loaded models to avoid memory bottlenecks on CPU and GPU
        OLLAMA_MAX_LOADED_MODELS = "3";

        # Keep alive duration fine, can increase if you do long sessions
        OLLAMA_KEEP_ALIVE = "15m";

        # Nvidia GPU
        CUDA_VISIBLE_DEVICES = "0";

        # Keep GPU overhead at 2GB, or try reducing to 1.5GB if you want to load larger models
        OLLAMA_GPU_OVERHEAD = "1610612736";

        # Keep flash attention enabled for performance but disable verbose logging unless troubleshooting
        OLLAMA_FLASH_ATTENTION = "1";
        # export OLLAMA_LOG_LEVEL=warning  # optionally reduce log noise
      };
    };
  };
}
