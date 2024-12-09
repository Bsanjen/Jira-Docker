# Use a base Ubuntu image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install basic packages
RUN apt-get update && \
    apt-get install -y wget curl vim && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Add a placeholder script (optional)
RUN echo '#!/bin/bash\necho "Hello from Ubuntu Container!"' > /app/start.sh && \
    chmod +x /app/start.sh

# Define the default command
CMD ["/app/start.sh"]
