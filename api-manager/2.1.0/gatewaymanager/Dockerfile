# wso2 gateway manager
FROM voogd/wso2-apimanagermysql:2.1.0
MAINTAINER Sjaak

# Carbon.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/carbon.xml" \
   -s "/x:Server" --type elem -n "HostName" -v "gatewaymanager.wso2:9443" \
   -s "/x:Server" --type elem -n "MgtHostName" -v "gatewaymanager.wso2" \
   -u "/x:Server/x:Security/x:KeyStore/x:Location" -v \
      "/wso2am/repository/resources/security/wso2gatewaymanager.jks" \
   -u "/x:Server/x:Security/x:KeyStore/x:Type" -v "JKS" \
   -u "/x:Server/x:Security/x:KeyStore/x:Password" -v "wso2carbon" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyAlias" -v "wso2gatewaymanagercert" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyPassword" -v "wso2carbon" \
   -s "/x:Server" --type elem -n "HostName" -v "gateway.wso2" \
   -s "/x:Server" --type elem -n "MgtHostName" -v "gatewaymanager.wso2" \
   /wso2am/repository/conf/carbon.xml 

# Catalina-server.xml
RUN xmlstarlet edit --inplace \
   -u "/Server/Service/Connector[@port="9443"]/@keystoreFile" -v \
      "/wso2am/repository/resources/security/wso2gatewaymanager.jks" \
   -u "/Server/Service/Connector[@port="9443"]/@keystorePass" -v "wso2carbon" \
   -s "/Server/Service/Connector[@port="9763"]" --type attr -n "proxyPort" -v "80" \
   -s "/Server/Service/Connector[@port="9443"]" --type attr -n "proxyPort" -v "443" \
   /wso2am/repository/conf/tomcat/catalina-server.xml 

# Broker.xml
RUN sed -i 's/wso2carbon.jks/wso2gatewaymanager.jks/g' \
    /wso2am/repository/conf/broker.xml

# EndpointConfig.properties
RUN sed -i 's/wso2carbon.jks/wso2gatewaymanager.jks/g' \
          /wso2am/repository/conf/identity/EndpointConfig.properties

# identity.xml
RUN sed -i 's/wso2carbon.jks/wso2gatewaymanager.jks/g' \
    /wso2am/repository/conf/identity/identity.xml

# axis2.xml
RUN sed -i 's/wso2carbon.jks/wso2gatewaymanager.jks/g' \
    /wso2am/repository/conf/axis2/axis2.xml

# Axis2.xml
RUN xmlstarlet edit --inplace \
    -u "/axisconfig/clustering/@enable" -v "true" \
    -u "/axisconfig/clustering/parameter[@name='membershipScheme']" -v "wka" \
    -u "/axisconfig/clustering/parameter[@name='domain']" -v "wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberHost']" -v "gatewaymanager.wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberPort']" -v "4200" \
    -d "/axisconfig/clustering/members/member" \
    -s "/axisconfig/clustering/parameter[@name='properties']" --type elem -n "property" -v "" \
    --var port80 '$prev' \
    -s '$port80' --type attr -n "name" -v "port.mapping.80" \
    -s '$port80' --type attr -n "value" -v "9763" \
    -s "/axisconfig/clustering/parameter[@name='properties']" --type elem -n "property" -v "" \
    --var port443 '$prev' \
    -s '$port443' --type attr -n "name" -v "port.mapping.443" \
    -s '$port443' --type attr -n "value" -v "9443" \
    /wso2am/repository/conf/axis2/axis2.xml 

# CORS _RevokeAPI_.xml
RUN xmlstarlet edit --inplace \
   -s "/api/handlers" --type elem -n "handler" -v '' \
   --var handler '$prev' \
   -s '$handler' --type attr -n "class" -v 'org.wso2.carbon.apimgt.gateway.handler.security.CORSRequestHandler' \
   -s '$handler' --type elem -n "property" -v '' \
   --var property '$prev' \
   -s '$property' --type attr -n "name" -v 'apiImplementationType' \
   -s '$property' --type attr -n "value" -v 'ENDPOINT' \
   /wso2am/repository/deployment/server/synapse-configs/default/api/_RevokeAPI_.xml

# CORS _TokenAPI_.xml
RUN xmlstarlet edit --inplace \
   -s "/api/handlers" --type elem -n "handler" -v '' \
   --var handler '$prev' \
   -s '$handler' --type attr -n "class" -v 'org.wso2.carbon.apimgt.gateway.handler.security.CORSRequestHandler' \
   -s '$handler' --type elem -n "property" -v '' \
   --var property '$prev' \
   -s '$property' --type attr -n "name" -v 'apiImplementationType' \
   -s '$property' --type attr -n "value" -v 'ENDPOINT' \
   /wso2am/repository/deployment/server/synapse-configs/default/api/_TokenAPI_.xml


# Api-manager.xml
RUN xmlstarlet edit --inplace \
    -u "/APIManager/CacheConfigurations/EnableGatewayTokenCache" -v "false" \
    -u "/APIManager/CacheConfigurations/EnableKeyManagerTokenCache" -v "true" \
    -u "/APIManager/APIKeyValidator/ServerURL" -v "https://identityserver.wso2:9443/services/" \
    -u "/APIManager/APIKeyValidator/Username" -v '${admin.username}' \
    -u "/APIManager/APIKeyValidator/Password" -v '${admin.password}' \
    -u "/APIManager/APIKeyValidator/KeyValidatorClientType" -v "WSClient" \
    -u "/APIManager/APIKeyValidator/EnableThriftServer" -v "false" \
    -u "/APIManager/AuthManager/ServerURL" -v "https://identityserver.wso2:9443/services/" \
    -u "/APIManager/AuthManager/Username" -v '${admin.username}' \
    -u "/APIManager/AuthManager/Password" -v '${admin.password}' \    
    -u "/APIManager/ThrottlingConfigurations/EnableAdvanceThrottling" -v "false" \
    -u "/APIManager/ThrottlingConfigurations/DataPublisher/Enabled" -v "true" \
    -u "/APIManager/ThrottlingConfigurations/DataPublisher/Type" -v "Binary" \
    -u "/APIManager/ThrottlingConfigurations/DataPublisher/ReceiverUrlGroup" -v "tcp://TrafficManager.wso2:9611" \
    -u "/APIManager/ThrottlingConfigurations/DataPublisher/AuthUrlGroup" -v "ssl://TrafficManager.wso2:9711" \
    -u "/APIManager/ThrottlingConfigurations/PolicyDeployer/ServiceURL" -v "https://TrafficManager.wso2:9443/services/" \
    -u "/APIManager/ThrottlingConfigurations/JMSConnectionDetails/Enabled" -v "false" \
    -u "/APIManager/ThrottlingConfigurations/JMSConnectionDetails/ServiceURL" -v "tcp://TrafficManager.wso2:5676" \
    -u "/APIManager/ThrottlingConfigurations/JMSConnectionDetails/Username" -v '${admin.username}' \
    -u "/APIManager/ThrottlingConfigurations/JMSConnectionDetails/Password" -v '${admin.password}' \
    -d "/APIManager/ThrottlingConfigurations/JMSConnectionDetails/JMSConnectionParameters" \
    -s "/APIManager/JWTConfiguration" --type elem -n "EnableJWTGeneration" -v "true" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ClaimsRetrieverImplClass" -v  "org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ConsumerDialectURI" -v "http://wso2.org/claims" \
    -s "/APIManager/JWTConfiguration" --type elem -n "SignatureAlgorithm" -v "NONE" \
    /wso2am/repository/conf/api-manager.xml 

RUN mkdir /wso2amserver && \
    cp -r /wso2am/repository/deployment/server /wso2amserver && \
    mkdir /wso2amserver/mediator

# Remove unused services
RUN     rm /wso2am/repository/deployment/server/webapps/api#am#publisher*.war && \
        rm /wso2am/repository/deployment/server/webapps/api#am#store*.war 

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

WORKDIR /wso2am/bin

ENTRYPOINT ["/bin/bash",  "/docker-start.sh"]

CMD -Dprofile=gateway-manager