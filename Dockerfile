# Use a base Ubuntu image
FROM ubuntu:20.04

# Set environment variables
ENV JIRA_HOME=/var/atlassian/application-data/jira
ENV JIRA_INSTALL_DIR=/opt/atlassian/jira
ENV JIRA_VERSION=9.12.0
ENV JIRA_PORT=7325

# Expose the Jira server port
EXPOSE ${JIRA_PORT}

# Install required dependencies and Java
RUN apt-get update && \
    apt-get install -y wget curl unzip openjdk-11-jdk && \
    apt-get clean

# Set JAVA_HOME environment variable for Java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create a user 'sanjen' to run Jira
RUN useradd --create-home --home-dir /home/sanjen --shell /bin/bash sanjen

# Download and install Jira Software
RUN wget https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${JIRA_VERSION}-x64.bin -O /tmp/jira-installer.bin && \
    chmod +x /tmp/jira-installer.bin && \
    echo -e "\nq\n1\n1\n/opt/atlassian/jira\n/var/atlassian/application-data/jira\n2\nn" | /tmp/jira-installer.bin && \
    rm /tmp/jira-installer.bin

# Set Jira's home directory permissions for 'sanjen'
RUN mkdir -p ${JIRA_HOME} && \
    chown -R sanjen:sanjen ${JIRA_HOME} && \
    chown -R sanjen:sanjen ${JIRA_INSTALL_DIR}

# Switch to the 'sanjen' user
USER sanjen

# Set the working directory to the Jira installation directory
WORKDIR /opt/atlassian/jira

# Start Jira directly
CMD ["./bin/start-jira.sh", "-fg", "--port", "7325"]
