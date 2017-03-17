# wso2 store
FROM voogd/wso2-apimanagermysql:2.1.0
MAINTAINER Sjaak

# Carbon.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/carbon.xml" \
   -d "/x:Server/x:HostName" \
   -s "/x:Server" --type elem -n "HostName" -v "store.wso2:9443" \
   -d "/x:Server/x:MgtHostName" \
   -s "/x:Server" --type elem -n "MgtHostName" -v "store.wso2" \
   -u "/x:Server/x:Security/x:KeyStore/x:Location" -v \
      "/wso2am/repository/resources/security/wso2store.jks" \
   -u "/x:Server/x:Security/x:KeyStore/x:Type" -v "JKS" \
   -u "/x:Server/x:Security/x:KeyStore/x:Password" -v "wso2carbon" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyAlias" -v "wso2storecert" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyPassword" -v "wso2carbon" \
   /wso2am/repository/conf/carbon.xml 

# Catalina-server.xml
RUN xmlstarlet edit --inplace \
   -u "/Server/Service/Connector[@port="9443"]/@keystoreFile" -v \
      "/wso2am/repository/resources/security/wso2store.jks" \
   -u "/Server/Service/Connector[@port="9443"]/@keystorePass" -v "wso2carbon" \
   /wso2am/repository/conf/tomcat/catalina-server.xml 

# Broker.xml
RUN sed -i 's/wso2carbon.jks/wso2store.jks/g' \
    /wso2am/repository/conf/broker.xml

# EndpointConfig.properties
RUN sed -i 's/wso2carbon.jks/wso2store.jks/g' \
          /wso2am/repository/conf/identity/EndpointConfig.properties

# identity.xml
RUN sed -i 's/wso2carbon.jks/wso2store.jks/g' \
    /wso2am/repository/conf/identity/identity.xml

# axis2.xml
RUN sed -i 's/wso2carbon.jks/wso2store.jks/g' \
    /wso2am/repository/conf/axis2/axis2.xml

# Registry.xml
RUN xmlstarlet edit --inplace \
    -s "/wso2registry" --type elem -n "dbConfig" -v "" \
    --var dbConfig '$prev' \
    -s '$dbConfig' --type attr -n "name" -v "govregistry" \
    -s '$dbConfig' --type elem -n "dataSource" -v "jdbc/WSO2REG_DB" \
    -s "/wso2registry" --type elem -n "remoteInstance" -v "" \
    --var remoteInstance '$prev' \
    -s '$remoteInstance' --type attr -n "url" -v "https://store.wso2" \
    -s '$remoteInstance' --type elem -n "id" -v "gov" \
    -s '$remoteInstance' --type elem -n "cacheId" -v "user@jdbc:mysql://mysql.wso2:3306/regdb" \
    -s '$remoteInstance' --type elem -n "dbConfig" -v "govregistry" \
    -s '$remoteInstance' --type elem -n "readOnly" -v "false" \
    -s '$remoteInstance' --type elem -n "enableCache" -v "true" \
    -s '$remoteInstance' --type elem -n "registryRoot" -v "/" \
    -s "/wso2registry" --type elem -n "mount" -v "" \
    --var mount '$prev' \
    -s '$mount' --type attr -n "path" -v "/_system/governance" \
    -s '$mount' --type attr -n "overwrite" -v "true" \
    -s '$mount' --type elem -n "instanceId" -v "gov" \
    -s '$mount' --type elem -n "targetPath" -v "/_system/governance" \
    -s "/wso2registry" --type elem -n "mount" -v "" \
    --var mount '$prev' \
    -s '$mount' --type attr -n "path" -v "/_system/config" \
    -s '$mount' --type attr -n "overwrite" -v "true" \
    -s '$mount' --type elem -n "instanceId" -v "gov" \
    -s '$mount' --type elem -n "targetPath" -v "/_system/config" \
    /wso2am/repository/conf/registry.xml 

# Api-manager.xml
RUN xmlstarlet edit --inplace \
    -u "/APIManager/CacheConfigurations/EnableGatewayTokenCache" -v "false" \
    -u "/APIManager/CacheConfigurations/EnableKeyManagerTokenCache" -v "true" \
    -u "/APIManager/OAuthConfigurations/RevokeAPIURL" -v "https://gateway.wso2:8243/revoke" \
    -u "/APIManager/AuthManager/ServerURL" -v "https://gatewaymanager.wso2:9443/services/" \
    -u "/APIManager/AuthManager/Username" -v '${admin.username}' \
    -u "/APIManager/AuthManager/Password" -v '${admin.password}' \
    -u "/APIManager/APIKeyValidator/ServerURL" -v "https://identityserver.wso2:9443/services/" \
    -u "/APIManager/APIKeyValidator/Username" -v '${admin.username}' \
    -u "/APIManager/APIKeyValidator/Password" -v '${admin.password}' \
    -u "/APIManager/APIKeyValidator/KeyValidatorClientType" -v "WSClient" \
    -u "/APIManager/APIKeyValidator/EnableThriftServer" -v "false" \   
    -u "/APIManager/APIGateway/Environments/Environment/ServerURL" -v "https://gateway.wso2:8243/services/" \
    -u "/APIManager/APIGateway/Environments/Environment/Username" -v '${admin.username}' \
    -u "/APIManager/APIGateway/Environments/Environment/Password" -v '${admin.password}' \
#    -u "/APIManager/APIGateway/Environments/Environment/GatewayEndpoint" -v "http://gateway.wso2:8280,https://gateway.wso2:8243" \
    -u "/APIManager/APIGateway/Environments/Environment/GatewayEndpoint" -v "http://gateway.wso2:8280,WSO2_GATEWAY_ENDPOINT" \
    -u "/APIManager/ThrottlingConfigurations/EnableAdvanceThrottling" -v "false" \
    -u "/APIManager/ThrottlingConfigurations/DataPublisher/Enabled" -v "false" \
    -u "/APIManager/ThrottlingConfigurations/BlockCondition/Enabled" -v "false" \
    -u "/APIManager/ThrottlingConfigurations/JMSConnectionDetails/Enabled" -v "false" \
    -s "/APIManager/APIStore" --type elem -n "GroupingExtractor" -v "org.wso2.carbon.apimgt.impl.DefaultGroupIDExtractorImpl" \
    -s "/APIManager/JWTConfiguration" --type elem -n "EnableJWTGeneration" -v "true" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ClaimsRetrieverImplClass" -v  "org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ConsumerDialectURI" -v "http://wso2.org/claims" \
    -s "/APIManager/JWTConfiguration" --type elem -n "SignatureAlgorithm" -v "NONE" \
    /wso2am/repository/conf/api-manager.xml 

# jndi.properties
RUN sed -i 's/localhost/trafficmanager.wso2/g' /wso2am/repository/conf/jndi.properties

# Remove unused services
RUN     rm /wso2am/repository/deployment/server/webapps/api#am#publisher*.war

RUN xmlstarlet edit --inplace \
    -u "/axisconfig/clustering/@enable" -v "true" \
    -u "/axisconfig/clustering/parameter[@name='membershipScheme']" -v "wka" \
    -u "/axisconfig/clustering/parameter[@name='domain']" -v "wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberHost']" -v "store.wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberPort']" -v "4000" \
    -d "/axisconfig/clustering/members/member" \
    /wso2am/repository/conf/axis2/axis2.xml

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

WORKDIR /wso2am/bin

ENTRYPOINT ["/bin/bash",  "/docker-start.sh"]

CMD -Dprofile=api-store