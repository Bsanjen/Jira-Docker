# Use an official Ubuntu image as a base
FROM ubuntu:latest

# Set a working directory
WORKDIR /app

# Update and install essential packages (if needed)
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set the default command to run when the container starts
CMD ["bash"]
