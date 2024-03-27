# Use an official NVIDIA CUDA image as base
FROM nvidia/cuda:12.0.1-cudnn8-runtime-ubuntu22.04

# Set a working directory
WORKDIR /workspace

# Install basic dependencies and JupyterLab
RUN apt-get update && apt-get install -y python3-pip git vim wget curl && \
    pip3 install notebook jupyterlab

# Copy the requirements file into the container
COPY requirements.txt /workspace

# Install Python packages specified in the requirements file
RUN pip3 install -r requirements.txt

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.notebook_dir='/workspace'"]
