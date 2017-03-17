# wso2 traffic manager
FROM voogd/wso2-apimanagermysql:2.1.0
MAINTAINER Sjaak

RUN mv /wso2am/repository/conf/registry_TM.xml /wso2am/repository/conf/registry.xml && \
    mv /wso2am/repository/conf/axis2/axis2_TM.xml /wso2am/repository/conf/axis2/axis2.xml && \
    rm -r -f /wso2am/repository/deployment/server/jaggeryapps/* && \
    rm -r -f /wso2am/repository/deployment/server/webapps/*

# axis2.xml
RUN sed -i 's/wso2carbon.jks/wso2trafficmanager.jks/g' \
    /wso2am/repository/conf/axis2/axis2.xml

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

WORKDIR /wso2am/bin

ENTRYPOINT ["/bin/bash",  "/docker-start.sh"]

CMD -Dprofile=traffic-manager


