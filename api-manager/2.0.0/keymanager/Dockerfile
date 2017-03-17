# wso2 keymanager
FROM voogd/wso2-apimanagermysql:2.0.0
MAINTAINER Sjaak

# Carbon.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/carbon.xml" \
   -u "/x:Server/x:Security/x:KeyStore/x:Location" -v \
      "/wso2am/repository/resources/security/wso2keymanager.jks" \
   -u "/x:Server/x:Security/x:KeyStore/x:Type" -v "JKS" \
   -u "/x:Server/x:Security/x:KeyStore/x:Password" -v "wso2carbon" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyAlias" -v "wso2keymanagercert" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyPassword" -v "wso2carbon" \
   -u "/x:Server/x:Axis2Config/x:HideAdminServiceWSDLs" -v "false" \
   /wso2am/repository/conf/carbon.xml 

# Catalina-server.xml
RUN xmlstarlet edit --inplace \
   -u "/Server/Service/Connector[@port="9443"]/@keystoreFile" -v \
      "/wso2am/repository/resources/security/wso2keymanager.jks" \
   -u "/Server/Service/Connector[@port="9443"]/@keystorePass" -v "wso2carbon" \
   /wso2am/repository/conf/tomcat/catalina-server.xml 

# Broker.xml
RUN sed -i 's/wso2carbon.jks/wso2keymanager.jks/g' \
    /wso2am/repository/conf/broker.xml

# EndpointConfig.properties
RUN sed -i 's/wso2carbon.jks/wso2keymanager.jks/g' \
          /wso2am/repository/conf/identity/EndpointConfig.properties

# identity.xml
RUN sed -i 's/wso2carbon.jks/wso2keymanager.jks/g' \
    /wso2am/repository/conf/identity/identity.xml

# axis2.xml
RUN sed -i 's/wso2carbon.jks/wso2keymanager.jks/g' \
    /wso2am/repository/conf/axis2/axis2.xml

# Carbon.xml
RUN xmlstarlet edit --inplace \
    -u "/Server/Axis2Config/HideAdminServiceWSDLs" -v "false" \
    /wso2am/repository/conf/carbon.xml 

# Api-manager.xml
RUN xmlstarlet edit --inplace \
    -u "/APIManager/CacheConfigurations/EnableGatewayTokenCache" -v "false" \
    -u "/APIManager/CacheConfigurations/EnableKeyManagerTokenCache" -v "true" \
    -u "/APIManager/APIKeyValidator/ServerURL" -v "https://keymanager.wso2:9443/services/" \
    -u "/APIManager/APIKeyValidator/Username" -v '${admin.username}' \
    -u "/APIManager/APIKeyValidator/Password" -v '${admin.password}' \
    -u "/APIManager/APIKeyValidator/KeyValidatorClientType" -v "WSClient" \
    -u "/APIManager/APIKeyValidator/EnableThriftServer" -v "false" \
    -u "/APIManager/OAuthConfigurations/RevokeAPIURL" -v "https://gateway.wso2:{port}" \
    -u "/APIManager/APIGateway/Environments/Environment/ServerURL" -v "https://gateway.wso2:9443/services/" \
    -s "/APIManager/JWTConfiguration" --type elem -n "EnableJWTGeneration" -v "true" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ClaimsRetrieverImplClass" -v  "org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ConsumerDialectURI" -v "http://wso2.org/claims" \
    -s "/APIManager/JWTConfiguration" --type elem -n "SignatureAlgorithm" -v "NONE" \
    /wso2am/repository/conf/api-manager.xml 

# Remove unused services
RUN     rm /wso2am/repository/deployment/server/webapps/api#am#publisher*.war && \
        rm /wso2am/repository/deployment/server/webapps/api#am#store*.war && \
        rm /wso2am/repository/deployment/server/webapps/api-import-export-*.war

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

VOLUME certificates

WORKDIR /wso2am/bin

ENTRYPOINT ["/bin/bash",  "/docker-start.sh"]

CMD -Dprofile=api-key-manager
