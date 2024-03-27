# GPU_JLinD
Environment for JupyterLab in docker container with GPU access.
This repo exclusively for my personal experience with my OS, hardware and environment. But if you have some issues - go on.

## Environment

- **OS**: Linux 6.8.1-arch1-1
- **Distro**: Arch Linux
- **Packages**: rolling
- **GPU**: NVIDIA RTX 3060 Ti
- **Docker Version**: Ensure you have the latest version installed, as this setup requires the use of the NVIDIA Container Toolkit.

## Prerequisites

Before you proceed with the installation, ensure you have the following prerequisites met:

1. **NVIDIA Drivers**: Ensure the latest NVIDIA drivers compatible with your GPU are installed.
2. **Docker**: Latest version of Docker installed.
3. **NVIDIA Docker Toolkit**: This is essential for enabling GPU access within Docker containers.

## Installation

Follow these steps to set up your JupyterLab environment with GPU support:

1. **Install NVIDIA Drivers (if not already installed):**
```bash
sudo pacman -S nvidia nvidia-utils nvidia-settings
```
```bash
yay -S nvidia-container-toolkit
```

## Configure Docker to Use the NVIDIA Runtime

You may need to explicitly tell Docker to use the NVIDIA runtime. This involves editing or creating the Docker daemon configuration file, typically found at /etc/docker/daemon.json. You'll need sudo privileges to edit this file.

First, check if the file exists and what its contents are:
```bash
cat /etc/docker/daemon.json
```
If the file doesn't exist or doesn't include references to the NVIDIA runtime, you'll want to create or modify it with the following content:
```json
{
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  },
  "default-runtime": "nvidia"
}
```

This configuration tells Docker to use the NVIDIA runtime as the default. After making these changes, restart Docker:
```bash
sudo systemctl restart docker
```
If you are using some kind of non-systemd then you should do your own good non-smoker healthy way docker restart.

## Try Running a Container

```bash
docker run --rm --gpus all nvidia/cuda:12.3.2-runtime-ubi8 nvidia-smi
```
