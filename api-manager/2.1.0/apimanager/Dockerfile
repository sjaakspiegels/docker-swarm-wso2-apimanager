# wso2base met Api manager
FROM voogd/wso2-javabase:1.8.0
MAINTAINER Sjaak

RUN wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" \
    http://product-dist.wso2.com/products/api-manager/2.1.0/wso2am-2.1.0.zip && \
    unzip wso2am-2.1.0.zip -d wso2am && \
    mv wso2am/*/* wso2am && \
    rmdir /wso2am/wso2am-2.1.0 && \
    rm wso2am-2.1.0.zip && \
    wget "https://docs.wso2.com/download/attachments/57743803/api-import-export-2.0.0-v0.war?version=1&modificationDate=1479484490000&api=v2&download=true" \
       -O /wso2am/repository/deployment/server/webapps/api-import-export-2.0.0-v0.war && \
    rm -f /wso2am/repository/deployment/server/webapps/*sample*.war

# Metrics.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/metrics.xml" \
   -u "/x:Metrics/x:Enabled" -v "true" \
   /wso2am/repository/conf/metrics.xml   
 
COPY ./metrics.properties /wso2am/repository/conf/metrics.properties

# Logging changes
# Disable Tomcat logging
RUN xmlstarlet edit --inplace \
    -d "/Server/Service/Engine/Host/Valve[classname='org.apache.catalina.valves.AccessLogValve']" \
    /wso2am/repository/conf/tomcat/catalina-server.xml

RUN xmlstarlet edit --inplace \
        -u "/APIManager/Analytics/DASServerURL" -v "tcp://das.wso2:7611" \
        -u "/APIManager/Analytics/DASRestApiURL" -v "https://das.wso2:9443" \
        /wso2am/repository/conf/api-manager.xml 

ENV WSO2_CARBON_ANALYTICS false

# Disable logging to files
# for docker logging is send to console
COPY ./log4j.properties /wso2am/repository/conf/log4j.properties

COPY ./docker-setOSConfig.sh /
RUN chmod +x /docker-setOSConfig.sh

COPY ./docker-setanalytics.sh /
RUN  chmod +x /docker-setanalytics.sh

# variable to set new admin password
ENV WSO2_ADMIN_PASSWORD admin

COPY ./docker-setadminpassword.sh /
RUN chmod +x /docker-setadminpassword.sh

VOLUME certificates

COPY ./docker-setcertificates.sh /
RUN chmod +x /docker-setcertificates.sh

COPY ./docker-setclustermembers.sh /
RUN chmod +x /docker-setclustermembers.sh

