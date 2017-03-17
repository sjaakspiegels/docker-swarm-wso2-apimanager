#!/bin/bash

/bin/bash /docker-setOSConfig.sh

/bin/bash /docker-setcertificates.sh

/bin/bash /docker-setadminpassword.sh

/bin/bash /docker-setanalytics.sh

/bin/bash /docker-setdatabasepassword.sh

/bin/bash /docker-setdatabasename.sh

/bin/bash /docker-setclustermembers.sh "worker" "publisher" "store"

sed -i "s%WSO2_GATEWAY_ENDPOINT%$WSO2_GATEWAY_ENDPOINT%g" \
    /wso2am/repository/conf/api-manager.xml

exec ./wso2server.sh "$@"