#!/bin/bash

xmlstarlet edit --inplace \
    -u "/UserManager/Realm/Configuration/AdminUser/Password" -v "$WSO2_ADMIN_PASSWORD" \
    /wso2am/repository/conf/user-mgt.xml 

sed -i "s/log4j.appender.LOGEVENT.password=.*/log4j.appender.LOGEVENT.password=$WSO2_ADMIN_PASSWORD/g" \
    /wso2am/repository/conf/log4j.properties 

sed -i "s/log4j.appender.DAS_AGENT.password=.*/log4j.appender.DAS_AGENT.password=$WSO2_ADMIN_PASSWORD/g" \
    /wso2am/repository/conf/log4j.properties 

