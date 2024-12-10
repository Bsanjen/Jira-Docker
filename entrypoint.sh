#!/bin/bash

# Set Jira configuration
export JIRA_HOME=${JIRA_HOME}
echo "Starting Jira with JIRA_HOME=${JIRA_HOME} on port ${JIRA_PORT}..."

# Start Jira
${JIRA_INSTALL}/bin/start-jira.sh -fg --port ${JIRA_PORT}
