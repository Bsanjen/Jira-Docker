# Use a Red Hat-based Atlassian Jira image
FROM registry.access.redhat.com/ubi8/ubi:latest

# Install dependencies required for Jira
RUN yum update -y && \
    yum install -y java-11-openjdk java-11-openjdk-devel wget tar && \
    yum clean all

# Set environment variables
ENV JIRA_HOME=/var/atlassian/application-data/jira \
    JIRA_INSTALL=/opt/atlassian/jira \
    JIRA_PORT=7325

# Create Jira directories
RUN mkdir -p ${JIRA_HOME} ${JIRA_INSTALL}

# Download and extract Jira Software
WORKDIR ${JIRA_INSTALL}
RUN wget -O jira.tar.gz https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-8.20.15.tar.gz && \
    tar -xzf jira.tar.gz --strip-components=1 && \
    rm -f jira.tar.gz

# Set permissions
RUN chmod -R 700 ${JIRA_HOME} && \
    chmod -R 700 ${JIRA_INSTALL}

# Expose the Jira application port
EXPOSE ${JIRA_PORT}

# Set the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start Jira Server
CMD ["/entrypoint.sh"]
