# wso2 analytics
FROM voogd/wso2-javabase:1.8.0
MAINTAINER Sjaak

# download identityserver
RUN wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" \
    http://product-dist.wso2.com/downloads/api-manager/2.0.0/identity-server/wso2is-5.2.0.zip && \
    unzip -qq wso2is-5.2.0.zip -d wso2is && \
    mv wso2is/*/* wso2is && \
    rmdir /wso2is/wso2is-5.2.0 && \
    rm wso2is-5.2.0.zip && \
    rm  /wso2is/repository/deployment/server/webapps/*.war  

# Get MySql Driver
# Unzip MySql in Wso2 folder
RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.zip && \
    unzip -j mysql-connector-java-5.1.40.zip mysql*bin.jar -d wso2is/repository/components/lib && \
    rm mysql-connector-java-5.1.40.zip

# default password for the mysqldatabase
ENV WSO2_MYSQL_PASSWORD "AY9VYj74L3FB"

COPY ./docker-setOSConfig.sh /
RUN chmod +x /docker-setOSConfig.sh

COPY ./docker-setdatabasepassword.sh /
RUN chmod +x /docker-setdatabasepassword.sh

COPY ./docker-setdatabasename.sh /
RUN chmod +x /docker-setdatabasename.sh

VOLUME certificates

COPY ./docker-setcertificates.sh /
RUN chmod +x /docker-setcertificates.sh

# variable to set new admin user and password
# ENV WSO2_ADMIN_USERNAME admin
ENV WSO2_ADMIN_PASSWORD admin

COPY ./docker-setadminpassword.sh /
RUN chmod +x /docker-setadminpassword.sh

COPY ./docker-setclustermembers.sh /
RUN  chmod +x /docker-setclustermembers.sh

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

# apimgtdb
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2AM_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2AM_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used for the API Manager" \
    -s '$datasource' --type elem -n "jndiConfig" -v "" \
    -s '$prev' --type elem -n "name" -v "jdbc/WSO2AM_DB" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306/apimgtdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "100" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2is/repository/conf/datasources/master-datasources.xml

# userdb
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2UM_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2UM_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used by user manager" \
    -s '$datasource' --type elem -n "jndiConfig" -v "" \
    -s '$prev' --type elem -n "name" -v "jdbc/WSO2UM_DB" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://mysql.wso2:3306/userdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "50" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2is/repository/conf/datasources/master-datasources.xml 

# regdb
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2REG_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2REG_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used for the API Manager" \
    -s '$datasource' --type elem -n "jndiConfig" -v "" \
    -s '$prev' --type elem -n "name" -v "jdbc/WSO2REG_DB" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://mysql.wso2:3306/regdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "50" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2is/repository/conf/datasources/master-datasources.xml 

# metricsdb
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2_METRICS_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2_METRICS_DB" \
    -s '$datasource' --type elem -n "description" -v "The MySQL datasource used for WSO2 Carbon Metrics" \
    -s '$datasource' --type elem -n "jndiConfig" -v "" \
    -s '$prev' --type elem -n "name" -v "jdbc/WSO2MetricsDB" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://mysql.wso2:3306/metricsdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "50" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2is/repository/conf/datasources/metrics-datasources.xml 

# user-mgt.xml
RUN xmlstarlet edit --inplace \
    -u "/UserManager/Realm/Configuration/Property[@name='dataSource']" \
    -v "jdbc/WSO2UM_DB" \
    -u "/UserManager/Realm/UserStoreManager/@class" -v "org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager" \
    -d "/UserManager/Realm/UserStoreManager/Property" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n "Property" -v "org.wso2.carbon.user.core.tenant.JDBCTenantManager" \
    -i '$prev' --type attr -n "name" -v "TenantManager" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n "Property" -v "false" \
    -i '$prev' --type attr -n "name" -v "ReadOnly" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "100" \
    -i '$prev' --type attr -n "name" -v "MaxUserNameListLength" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "false" \
    -i '$prev' --type attr -n "name" -v "IsEmailUserName" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "default" \
    -i '$prev' --type attr -n "name" -v "DomainCalculation" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "SHA-256" \
    -i '$prev' --type attr -n "name" -v "PasswordDigest" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "true" \
    -i '$prev' --type attr -n "name" -v "StoreSaltedPassword" \	
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "true" \
    -i '$prev' --type attr -n "name" -v "ReadGroups" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "true" \
    -i '$prev' --type attr -n "name" -v "WriteGroups" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "false" \
    -i '$prev' --type attr -n "name" -v "UserNameUniqueAcrossTenants" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "^[\S]{5,30}$" \
    -i '$prev' --type attr -n "name" -v "PasswordJavaRegEx" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "^[\S]{5,30}$" \
    -i '$prev' --type attr -n "name" -v "PasswordJavaScriptRegEx" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "^[^~!#$;%^*+={}\\|\\\\&lt;&gt;,\'\"]{3,50}$" \
    -i '$prev' --type attr -n "name" -v "UsernameJavaRegEx" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "^[\S]{3,50}$" \
    -i '$prev' --type attr -n "name" -v "UsernameJavaScriptRegEx" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "mail" \
    -i '$prev' --type attr -n "name" -v "UsernameAttribute" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "[a-zA-Z0-9@._-|//]{3,50}$" \
    -i '$prev' --type attr -n "name" -v "UsernameWithEmailJavaScriptRegEx" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "^[^~!#$;%^*+={}\\|\\\\&lt;&gt;,\'\"]{3,30}$" \
    -i '$prev' --type attr -n "name" -v "RolenameJavaRegEx" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "^[\S]{3,30}$" \
    -i '$prev' --type attr -n "name" -v "RolenameJavaScriptRegEx" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "true" \
    -i '$prev' --type attr -n "name" -v "UserRolesCacheEnabled" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "100" \
    -i '$prev' --type attr -n "name" -v "MaxRoleNameListLength" \	
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "false" \
    -i '$prev' --type attr -n "name" -v "SharedGroupEnabled" \	
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "false" \
    -i '$prev' --type attr -n "name" -v "SCIMEnabled" \
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "true" \
    -i '$prev' --type attr -n "name" -v "CaseInsensitiveUsername" \
    /wso2is/repository/conf/user-mgt.xml 

# Registry.xml
RUN xmlstarlet edit --inplace \
    -s "/wso2registry" --type elem -n "dbConfig" -v "" \
    --var dbConfig '$prev' \
    -s '$dbConfig' --type attr -n "name" -v "govregistry" \
    -s '$dbConfig' --type elem -n "dataSource" -v "jdbc/WSO2REG_DB" \
    -s "/wso2registry" --type elem -n "remoteInstance" -v "" \
    --var remoteInstance '$prev' \
    -s '$remoteInstance' --type attr -n "url" -v "https://identityserver.wso2:9443/registry" \
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
    /wso2is/repository/conf/registry.xml 


# Axis2.xml
RUN xmlstarlet edit --inplace \
    -u "/axisconfig/clustering/@enable" -v "true" \
    -u "/axisconfig/clustering/parameter[@name='membershipScheme']" -v "wka" \
    -u "/axisconfig/clustering/parameter[@name='domain']" -v "is.wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberHost']" -v "identityserver.wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberPort']" -v "4500" \
    -d "/axisconfig/clustering/members/member" \
    /wso2is/repository/conf/axis2/axis2.xml 

# Carbon.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/carbon.xml" \
   -d "/x:Server/x:HostName" \
   -s "/x:Server" --type elem -n "HostName" -v "identityserver.wso2:9443" \
   -d "/x:Server/x:MgtHostName" \
   -s "/x:Server" --type elem -n "MgtHostName" -v "identityserver.wso2" \
   -u "/x:Server/x:Ports/x:Offset" -v "0" \
   -u "/x:Server/x:Security/x:KeyStore/x:Location" -v \
      "/wso2is/repository/resources/security/wso2identityserver.jks" \
   -u "/x:Server/x:Security/x:KeyStore/x:Type" -v "JKS" \
   -u "/x:Server/x:Security/x:KeyStore/x:Password" -v "wso2carbon" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyAlias" -v "wso2identityservercert" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyPassword" -v "wso2carbon" \
   -u "/x:Server/x:Axis2Config/x:HideAdminServiceWSDLs" -v "false" \
   /wso2is/repository/conf/carbon.xml 


# identity.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/carbon.xml" \
   -s "/x:Server/x:JDBCPersistenceManager" --type elem -n "SessionDataPersist" -v "" \
   --var SessionDataPersist '$prev' \
   -s '$SessionDataPersist' --type elem -n "Enable" -v "true" \
   -s '$SessionDataPersist' --type elem -n "Temporary" -v "false" \
   -s '$SessionDataPersist' --type elem -n "PoolSize" -v "0" \
   -s '$SessionDataPersist' --type elem -n "SessionDataCleanup" -v "" \
   --var SessionDataCleanup '$prev' \
   -s '$SessionDataCleanup' --type elem -n "Enable" -v "true" \
   -s '$SessionDataCleanup' --type elem -n "CleanUpTimeout" -v "20160" \
   -s '$SessionDataCleanup' --type elem -n "CleanUpPeriod" -v "1140" \
   -s '$SessionDataPersist' --type elem -n "OperationDataCleanup" -v "" \
   --var OperationDataCleanup '$prev' \
   -s '$OperationDataCleanup' --type elem -n "Enable" -v "true" \
   -s '$OperationDataCleanup' --type elem -n "CleanUpPeriod" -v "720" \
   /wso2is/repository/conf/identity/identity.xml 

# Metrics.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/metrics.xml" \
   -u "/x:Metrics/x:Enabled" -v "true" \
   /wso2is/repository/conf/metrics.xml  

COPY ./metrics.properties /wso2is/repository/conf/metrics.properties

# auth_config.json
RUN sed -i 's/wso2carbon.jks/wso2identityserver.jks/g' \
          /wso2is/repository/deployment/server/jaggeryapps/dashboard/authentication/auth_config.json

# axis2.xml
RUN sed -i 's/wso2carbon.jks/wso2identityserver.jks/g' \
    /wso2is/repository/conf/axis2/axis2.xml

# Catalina-server.xml
RUN xmlstarlet edit --inplace \
   -u "/Server/Service/Connector[@port="9443"]/@keystoreFile" -v \
      "/wso2is/repository/resources/security/wso2identityserver.jks" \
   -u "/Server/Service/Connector[@port="9443"]/@keystorePass" -v "wso2carbon" \
   /wso2is/repository/conf/tomcat/catalina-server.xml 

# EndpointConfig.properties
RUN sed -i 's/wso2carbon.jks/wso2identityserver.jks/g' \
          /wso2is/repository/conf/identity/EndpointConfig.properties

# identity.xml
RUN sed -i 's/wso2carbon.jks/wso2identityserver.jks/g' \
    /wso2is/repository/components/features/org.wso2.carbon.identity.core.server_5.2.2/identity.xml

# identity.xml
RUN sed -i 's/wso2carbon.jks/wso2identityserver.jks/g' \
    /wso2is/repository/conf/identity/identity.xml

# Api-manager.xml
RUN xmlstarlet edit --inplace \
    -u "/APIManager/CacheConfigurations/EnableGatewayTokenCache" -v "false" \
    -u "/APIManager/CacheConfigurations/EnableKeyManagerTokenCache" -v "true" \
    -u "/APIManager/APIKeyValidator/ServerURL" -v "https://identityserver.wso2:9443/services/" \
    -u "/APIManager/APIKeyValidator/Username" -v '${admin.username}' \
    -u "/APIManager/APIKeyValidator/Password" -v '${admin.password}' \
    -u "/APIManager/APIKeyValidator/KeyValidatorClientType" -v "WSClient" \
    -u "/APIManager/APIKeyValidator/EnableThriftServer" -v "false" \
    -u "/APIManager/OAuthConfigurations/RevokeAPIURL" -v "https://gateway.wso2:{https.nio.port}/revoke" \
    -u "/APIManager/APIGateway/Environments/Environment/ServerURL" -v "https://gateway.wso2:{port}}/services/,https://gatewaymanager.wso2:{port}/services/" \
    -s "/APIManager/JWTConfiguration" --type elem -n "EnableJWTGeneration" -v "true" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ClaimsRetrieverImplClass" -v  "org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever" \
    -s "/APIManager/JWTConfiguration" --type elem -n "ConsumerDialectURI" -v "http://wso2.org/claims" \
    -s "/APIManager/JWTConfiguration" --type elem -n "SignatureAlgorithm" -v "NONE" \
    /wso2is/repository/conf/api-manager.xml 

# Logging changes
# Disable Tomcat logging
RUN xmlstarlet edit --inplace \
    -d "/Server/Service/Engine/Host/Valve[classname='org.apache.catalina.valves.AccessLogValve']" \
    /wso2is/repository/conf/tomcat/catalina-server.xml

# Disable logging to files
# for docker logging is send to console
COPY ./log4j.properties /wso2is/repository/conf/log4j.properties

WORKDIR /wso2is/bin

ENTRYPOINT ["/bin/bash",  "/docker-start.sh"]