# wso2 analytics
FROM voogd/wso2-javabase:1.8.0
MAINTAINER Sjaak

# COPY ./wso2am-analytics-2.0.0.zip /

# download analytics
RUN wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" \
    http://product-dist.wso2.com/products/api-manager/2.0.0/wso2am-analytics-2.0.0.zip && \
    unzip wso2am-analytics-2.0.0.zip -d wso2analytics && \
    mv wso2analytics/*/* wso2analytics && \
    rmdir /wso2analytics/wso2am-analytics-2.0.0 && \
    rm wso2am-analytics-2.0.0.zip 
    
# Get MySql Driver
# Unzip MySql in Wso2 folder
RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.zip && \
    unzip -j mysql-connector-java-5.1.40.zip mysql*bin.jar -d wso2analytics/repository/components/lib && \
    rm mysql-connector-java-5.1.40.zip
    
# default password for the mysqldatabase
ENV WSO2_MYSQL_PASSWORD "AY9VYj74L3FB"

# Disable logging to files
# for docker logging is send to console
COPY ./log4j.properties /wso2analytics/repository/conf/log4j.properties

COPY ./docker-setbatchschedules.sh /
RUN chmod +x /docker-setbatchschedules.sh

COPY ./docker-setOSConfig.sh /
RUN chmod +x /docker-setOSConfig.sh

COPY ./docker-setdatabasepassword.sh /
RUN chmod +x /docker-setdatabasepassword.sh

COPY ./docker-setdatabasename.sh /
RUN chmod +x /docker-setdatabasename.sh

VOLUME certificates

COPY ./docker-setcertificates.sh /
RUN chmod +x /docker-setcertificates.sh

COPY ./docker-setclustermembers.sh /
RUN  chmod +x /docker-setclustermembers.sh

# variable to set new admin user and password
# ENV WSO2_ADMIN_USERNAME admin
ENV WSO2_ADMIN_PASSWORD admin

COPY ./docker-setadminpassword.sh /
RUN chmod +x /docker-setadminpassword.sh

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

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
    -s '$configuration' --type elem -n "maxActive" -v "200" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2analytics/repository/conf/datasources/master-datasources.xml 

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
    -s '$configuration' --type elem -n "maxActive" -v "200" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2analytics/repository/conf/datasources/master-datasources.xml 

# statdb
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2AM_STATS_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2AM_STATS_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used for the API Manager" \
    -s '$datasource' --type elem -n "jndiConfig" -v "" \
    -s '$prev' --type elem -n "name" -v "jdbc/WSO2AM_STATS_DB" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://mysql.wso2:3306/statdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "200" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2analytics/repository/conf/datasources/stats-datasources.xml 

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
    -s '$configuration' --type elem -n "maxActive" -v "200" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2analytics/repository/conf/datasources/metrics-datasources.xml 

# wso2_analytics_fs_db
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2_ANALYSTICS_FS_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2_ANALYTICS_FS_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used for analytics file system" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://mysql.wso2:3306/analytics_fs_store?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "200" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2analytics/repository/conf/datasources/analytics-datasources.xml 

# wso2_analytics_event_store_db
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2_ANALYTICS_EVENT_STORE_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2_ANALYTICS_EVENT_STORE_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used for analytics record store" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://mysql.wso2:3306/analytics_event_store?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "200" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2analytics/repository/conf/datasources/analytics-datasources.xml 

# wso2_analytics_processed_data_store_db
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used for analytics record store" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://mysql.wso2:3306/analytics_processed_data_store?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "200" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2analytics/repository/conf/datasources/analytics-datasources.xml 

# user-mgt.xml
RUN xmlstarlet edit --inplace \
    -u "/UserManager/Realm/Configuration/Property[@name='dataSource']" \
    -v "jdbc/WSO2UM_DB" \
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
    /wso2analytics/repository/conf/user-mgt.xml 

# Registry.xml
RUN xmlstarlet edit --inplace \
    -s "/wso2registry" --type elem -n "dbConfig" -v "" \
    --var dbConfig '$prev' \
    -s '$dbConfig' --type attr -n "name" -v "govregistry" \
    -s '$dbConfig' --type elem -n "dataSource" -v "jdbc/WSO2REG_DB" \
    -s "/wso2registry" --type elem -n "remoteInstance" -v "" \
    --var remoteInstance '$prev' \
    -s '$remoteInstance' --type attr -n "url" -v "https://das.wso2:9443/registry" \
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
    /wso2analytics/repository/conf/registry.xml 

# Spark-jdbc-config.xml
RUN xmlstarlet edit --inplace \
    -u "/spark-jdbc-configuration/database[@name='mysql']/typeMapping/stringType" -v "VARCHAR(100)" \
    /wso2analytics/repository/conf/analytics/spark/spark-jdbc-config.xml

# Axis2.xml
RUN xmlstarlet edit --inplace \
    -u "/axisconfig/clustering/@enable" -v "true" \
    -u "/axisconfig/clustering/parameter[@name='membershipScheme']" -v "wka" \
    -u "/axisconfig/clustering/parameter[@name='domain']" -v "wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberHost']" -v "das.wso2" \
    -u "/axisconfig/clustering/parameter[@name='localMemberPort']" -v "4300" \
    -d "/axisconfig/clustering/members/member" \
    /wso2analytics/repository/conf/axis2/axis2.xml 

# Carbon.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/carbon.xml" \
   -d "/x:Server/x:HostName" \
   -s "/x:Server" --type elem -n "HostName" -v "das.wso2:9443" \
   -d "/x:Server/x:MgtHostName" \
   -s "/x:Server" --type elem -n "MgtHostName" -v "das.wso2" \
   -u "/x:Server/x:Ports/x:Offset" -v "0" \
   -u "/x:Server/x:Security/x:KeyStore/x:Location" -v \
      "/wso2analytics/repository/resources/security/wso2das.jks" \
   -u "/x:Server/x:Security/x:KeyStore/x:Type" -v "JKS" \
   -u "/x:Server/x:Security/x:KeyStore/x:Password" -v "wso2carbon" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyAlias" -v "wso2dascert" \
   -u "/x:Server/x:Security/x:KeyStore/x:KeyPassword" -v "wso2carbon" \
   /wso2analytics/repository/conf/carbon.xml 

# Logging changes
# Disable Tomcat logging
RUN xmlstarlet edit --inplace \
    -d "/Server/Service/Engine/Host/Valve[classname='org.apache.catalina.valves.AccessLogValve']" \
    /wso2analytics/repository/conf/tomcat/catalina-server.xml

# metrics.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/metrics.xml" \
   -u "/x:Metrics/x:Enabled" -v "true" \
   /wso2analytics/repository/conf/metrics.xml   

COPY ./metrics.properties /wso2analytics/repository/conf/metrics.properties

# change schedule batch jobs
#WORKDIR /wso2analytics/repository/components/features/org.wso2.analytics.apim._2.0.0/template-manager/sparktemplates
#RUN \
#    xmlstartlet edit --inplace \
#        -u "/Analytics/CronExpression" -v "0 0 23 * * ?" \
#        APIMAnalytics-AbnormalTierUsageAlertAvailabilityAlert-batch1.xml &&
#    xmlstartlet edit --inplace \
#        -u "/Analytics/CronExpression" -v "0 0 12 * * ?" \
#        APIMAnalytics-ResponsePerApiStatGenerator-ResponsePerAPIStatGenerator-batch1.xml &&
#    xmlstartlet edit --inplace \
#        -u "/Analytics/CronExpression" -v "0 0 23 * * ?" \
#        APIMAnalytics-ResponseStatGenerator-ResponseStatGenerator-batch1.xml &&
#    xmlstartlet edit --inplace \
#        -u "/Analytics/CronExpression" -v "0 0 23 * * ?" \
#        APIMAnalytics-RequestStatGenerator-RequestStatGenerator-batch1.xml &&
#    xmlstartlet edit --inplace \
#        -u "/Analytics/CronExpression" -v "0 0 12 1/7 * ? *" \
#        APIMAnalytics-ConfigureAccessToken-ConfigureAccessToken-batch1.xml &&
        

WORKDIR /wso2analytics/bin

ENTRYPOINT ["/bin/bash",  "/docker-start.sh"]