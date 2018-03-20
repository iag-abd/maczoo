FROM debian:9-slim

ENV DEBIAN_FRONTEND noninteractive
ARG user=app
ARG group=app
ARG uid=1000
ARG gid=1000

RUN echo "basic upgrade and cleanup" && \
    apt-get update --fix-missing && \
    apt-get install -qq -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      gnupg2 \
      jq \
      python \
      ruby \
      sudo \
      unzip && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/* && \
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

RUN echo "install aws cli" && \
    cd /usr/src && \
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip  && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN echo "install some gems" && \
    gem install aws-sdk bundler bump cfndsl trollop rspec

RUN echo "setup node for aws" && \
    npm install aws-sdk dynamodb-doc

RUN echo "setup packer" && \
     cd /usr/src && \
     curl -qL -o packer.zip https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_amd64.zip && \
     unzip packer.zip && \
     mv packer /usr/local/bin/ && \
     rm -f packer.zip && \
     packer -v

RUN echo "create app user" && \
    groupadd -g ${gid} ${group} && \
    useradd -d /home/${user} -k /etc/skel -u ${uid} -g ${gid} -m -s /bin/bash ${user}  && \
    echo "${user} ALL = NOPASSWD: ALL" > /etc/sudoers.d/${user} && \
    chown -R ${user}: /home/${user} && \
    mkdir /app && \
    chown ${user}: /app && \
    echo "finished creating ${user}"

WORKDIR /app

USER ${user}
