FROM jenkins/jenkins:lts

USER root

RUN apt-get update \
    && apt install docker.io -y \
    && apt install ansible -y \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip -u awscliv2.zip \
    && ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update