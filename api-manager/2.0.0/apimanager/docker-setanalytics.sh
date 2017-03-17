#!/bin/bash

Analytics="${WSO2_CARBON_ANALYTICS:false}"

if [ "$Analytics" == "true" ]; then

    echo "Enable analytics"

    xmlstarlet edit --inplace \
        -u "/APIManager/Analytics/Enabled" -v "true" \
        /wso2am/repository/conf/api-manager.xml 
fi

