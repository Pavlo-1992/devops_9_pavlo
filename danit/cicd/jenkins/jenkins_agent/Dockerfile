FROM jenkins/inbound-agent:latest

# Switch to root user to install additional packages
USER root

# Update and install required packages
RUN apt-get update && \
    apt-get install -y ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    jammy stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update

# Install Docker CLI and other tools
RUN apt-get install -y docker-ce-cli docker-compose-plugin git

RUN groupadd -g 982 docker && \
    usermod -aG docker jenkins

# Switch back to Jenkins user
USER jenkins

