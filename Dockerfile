# Use an Atlassian-compatible base image for Jira
FROM atlassian/jira-software:latest

# Set environment variables
ENV JIRA_HOME=/var/atlassian/jira
ENV JIRA_PORT=7325

# Expose the Jira server port (7325)
EXPOSE 7325

# Add the start script if it does not exist
COPY start-jira.sh /opt/atlassian/jira/bin/start-jira.sh

# Make the start script executable
RUN chmod +x /opt/atlassian/jira/bin/start-jira.sh

# Start Jira Server with the custom port
CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg", "--port", "7325"]
