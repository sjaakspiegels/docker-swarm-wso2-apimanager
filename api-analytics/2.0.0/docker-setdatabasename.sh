#!/bin/bash

sed -i "s%jdbc:mysql://.*.wso2:3306%jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306%g" \
    /wso2analytics/repository/conf/datasources/master-datasources.xml

sed -i "s%jdbc:mysql://.*.wso2:3306%jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306%g" \
    /wso2analytics/repository/conf/datasources/metrics-datasources.xml

sed -i "s%jdbc:mysql://.*.wso2:3306%jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306%g" \
    /wso2analytics/repository/conf/datasources/stats-datasources.xml

sed -i "s%jdbc:mysql://.*.wso2:3306%jdbc:mysql://$WSO2_MYSQL_SERVER.wso2:3306%g" \
    /wso2analytics/repository/conf/datasources/analytics-datasources.xml 
