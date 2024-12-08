# Use an Atlassian-compatible base image for Jira
FROM atlassian/jira-software:latest

# Set environment variables
ENV JIRA_HOME=/var/atlassian/jira
ENV JIRA_PORT=7325

# Expose the Jira server port (7325)
EXPOSE 7325

# Start Jira Server with the custom port
CMD ["start-jira.sh", "-fg", "--port", "7325"]
