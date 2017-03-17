# wso2 change admin password
FROM voogd/wso2-apimanagermysql:2.0.0
MAINTAINER Sjaak

# Install ant.
RUN \
  apt-get update && \
  apt-get install -y ant && \
  rm -rf /var/lib/apt/lists/*

RUN cp /wso2am/repository/components/lib/mysql*bin.jar /wso2am/lib

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

WORKDIR /wso2am/bin

ENTRYPOINT ["/bin/bash",  "/docker-start.sh"]

