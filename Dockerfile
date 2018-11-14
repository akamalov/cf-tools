FROM ubuntu:18.04
ENV LAST_UPDATE=2018-11-08
ENV GOROOT="/usr/local/go"
ENV GOPATH="$HOME/Projects"
ENV PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
ENV GOOS="linux"

# Install.
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends apt-utils && \
  apt-get -y upgrade && \
  apt-get -y install build-essential curl ruby ruby-dev libxml2-dev libsqlite3-dev libxslt1-dev libpq-dev libmysqlclient-dev zlib1g-dev wget nfs-common cifs-utils smbclient python python-pip git sshpass && \
  apt autoremove && \
  apt clean && \
  gem install bosh_cli --no-ri --no-rdoc && \
  curl -k -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx -C /usr/bin/ | xargs -0 chmod 755 /usr/bin/cf && \
  curl -k -L -o /usr/bin/jq  https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 | xargs -0 chmod 755 /usr/bin/jq && \
  curl -k -L -o /usr/bin/cfops https://github.com/pivotalservices/cfops/releases/download/v3.1.7/cfops_linux64 | xargs -0 chmod 755 /usr/bin/cfops && \
  cd /usr/bin && mkdir plugins && cd plugins && \
  curl -k -L "https://github.com/pivotalservices/cfops-mysql-plugin/releases/download/v0.0.22/cfops-mysql-plugin_binaries.tgz" | tar -zx && \
  chmod 755 pipeline/output/builds/linux64/cfops-mysql-plugin && \
  mv pipeline/output/builds/linux64/cfops-mysql-plugin . && \
  curl -k -L "https://github.com/pivotalservices/cfops-redis-plugin/releases/download/v0.0.14/cfops-redis-plugin_binaries.tgz" | tar -zx && \
  chmod 755 pipeline/output/builds/linux64/cfops-redis-plugin && \
  mv pipeline/output/builds/linux64/cfops-redis-plugin . && \
  curl -k -L "https://github.com/pivotalservices/cfops-rabbitmq-plugin/releases/download/v0.0.5/cfops-rabbitmq-plugin_binaries.tgz" | tar -zx && \
  chmod 755 pipeline/output/linux64/cfops-rabbitmq-plugin && \
  mv pipeline/output/linux64/cfops-rabbitmq-plugin . && \
  curl -k -L "https://github.com/pivotalservices/cfops-nfs-plugin/releases/download/v0.0.4/cfops-nfs-plugin_binaries.tgz" | tar -zx && \
  chmod 755 pipeline/output/builds/linux64/cfops-nfs-plugin && \
  mv pipeline/output/builds/linux64/cfops-nfs-plugin . && \
  gem install cf-uaac && \
  cd  /tmp &&  \
  curl -L -k https://github.com/gohugoio/hugo/releases/download/v0.51/hugo_0.51_Linux-64bit.tar.gz | tar -zx -C /usr/bin/ | xargs -0 chmod 755 /usr/bin/hugo && \
  rm /usr/bin/README.md /usr/bin/LICENSE && \
  curl -k -L -o /usr/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc  | xargs -0 chmod 755 /usr/bin/mc && \
  curl -k -L https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz | tar -zx -C /usr/local/ && \
  echo "export GOROOT=/usr/local/go" >> ~/.bashrc && \
  echo "export GOPATH=$HOME/Projects" >> ~/.bashrc && \
  echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> ~/.bashrc && \
  mkdir -p ~/Projects/bin && \
  mkdir -p ~/Projects/src && \
  mkdir -p ~/Projects/pkg && \
  /bin/bash -c "source ~/.bashrc" && \
  go get -insecure github.com/cloudfoundry/cli && \
  go get code.cloudfoundry.org/cfdot && \
  cd  $GOPATH/src/code.cloudfoundry.org/cfdot && \
  GOOS=linux && \
  go build . && \
  mv cfdot /usr/bin/ && \
  chmod 755 /usr/bin/cfdot && \
  pip install --upgrade --user awscli
