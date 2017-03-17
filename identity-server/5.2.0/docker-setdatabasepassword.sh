# datasources
xmlstarlet edit --inplace \
    -u "/datasources-configuration/datasources/datasource[name='WSO2AM_DB']/definition/configuration/password" \
    -v "$WSO2_MYSQL_PASSWORD" \
    -u "/datasources-configuration/datasources/datasource[name='WSO2UM_DB']/definition/configuration/password" \
    -v "$WSO2_MYSQL_PASSWORD" \
    -u "/datasources-configuration/datasources/datasource[name='WSO2REG_DB']/definition/configuration/password" \
    -v "$WSO2_MYSQL_PASSWORD" \
    -u "/datasources-configuration/datasources/datasource[name='WSO2AM_STATS_DB']/definition/configuration/password" \
    -v "$WSO2_MYSQL_PASSWORD" \
    -u "/datasources-configuration/datasources/datasource[name='WSO2_MB_STORE_DB']/definition/configuration/password" \
    -v "$WSO2_MYSQL_PASSWORD" \
    /wso2is/repository/conf/datasources/master-datasources.xml