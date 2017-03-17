# wso2-apimanager met mySql
FROM voogd/wso2-apimanager:2.1.0
MAINTAINER Sjaak

# Get MySql Driver
# Unzip MySql in Wso2 folder
RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.zip && \
    unzip -j mysql-connector-java-5.1.40.zip mysql*bin.jar -d wso2am/repository/components/lib && \
    rm mysql-connector-java-5.1.40.zip

# default password for the mysqldatabase
ENV WSO2_MYSQL_PASSWORD "AY9VYj74L3FB"
ENV WSO2_MYSQL_SERVER "mysql"

COPY ./docker-setdatabasepassword.sh /
RUN chmod +x /docker-setdatabasepassword.sh

COPY ./docker-setdatabasename.sh /
RUN chmod +x /docker-setdatabasename.sh

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
    /wso2am/repository/conf/datasources/master-datasources.xml

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
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306/userdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "100" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2am/repository/conf/datasources/master-datasources.xml 

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
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306/regdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "100" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2am/repository/conf/datasources/master-datasources.xml 

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
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306/statdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "100" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2am/repository/conf/datasources/master-datasources.xml 

# mbstoredb
RUN xmlstarlet edit --inplace \
    -d "/datasources-configuration/datasources/datasource[name='WSO2_MB_STORE_DB']" \
    -s "/datasources-configuration/datasources" --type elem -n "datasource" -v "" \
    --var datasource '$prev' \
    -s '$datasource' --type elem -n "name" -v "WSO2_MB_STORE_DB" \
    -s '$datasource' --type elem -n "description" -v "The datasource used for message broker database" \
    -s '$datasource' --type elem -n "jndiConfig" -v "" \
    -s '$prev' --type elem -n "name" -v "WSO2MBStoreDB" \
    -s '$datasource' --type elem -n "definition" -v "" \
    --var definition '$prev' \
    -s '$definition' --type attr -n "type" -v "RDBMS" \
    -s '$definition' --type elem -n "configuration" -v "" \
    --var configuration '$prev' \
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306/mbstoredb?autoReconnect=true&amp;useSSL=false&amp;relaxAutoCommit=true" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "100" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2am/repository/conf/datasources/master-datasources.xml 

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
    -s '$configuration' --type elem -n "url" -v "jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306/metricsdb?autoReconnect=true&amp;useSSL=false" \
    -s '$configuration' --type elem -n "username" -v "apisqluser" \
    -s '$configuration' --type elem -n "password" -v "$WSO2_MYSQL_PASSWORD" \
    -s '$configuration' --type elem -n "driverClassName" -v "com.mysql.jdbc.Driver" \
    -s '$configuration' --type elem -n "maxActive" -v "100" \
    -s '$configuration' --type elem -n "maxWait" -v "60000" \
    -s '$configuration' --type elem -n "testOnBorrow" -v "true" \
    -s '$configuration' --type elem -n "validationQuery" -v "SELECT 1" \
    -s '$configuration' --type elem -n "validationInterval" -v "30000" \
    /wso2am/repository/conf/datasources/metrics-datasources.xml

# api-manager.xml 
RUN xmlstarlet edit --inplace \
    -u "/APIManager/DataSourceName" \
    -v "jdbc/WSO2AM_DB" \
    /wso2am/repository/conf/api-manager.xml 

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
    -s "/UserManager/Realm/UserStoreManager" --type elem -n Property -v "^(?:(?=^.{3,50}$)^[a-zA-Z0-9]+$|(?!={3,50}$)^[a-zA-Z0-9._-]+@{0,1}[a-zA-Z0-9.-]+\.{0,1}[a-zA-Z]{2,4})$" \
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
    /wso2am/repository/conf/user-mgt.xml 

# Carbon.xml
RUN xmlstarlet edit --inplace \
   -N x="http://wso2.org/projects/carbon/carbon.xml" \
   -s "/x:Server" --type elem -n "EnableEmailUserName" -v "true" \
   /wso2am/repository/conf/carbon.xml    

