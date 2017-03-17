#!/bin/bash

/bin/bash /docker-setOSConfig.sh

/bin/bash /docker-setcertificates.sh

/bin/bash /docker-setadminpassword.sh

/bin/bash /docker-setdatabasename.sh

/bin/bash /docker-setdatabasepassword.sh

/bin/bash /docker-setanalytics.sh

if [ ! -d /wso2am/repository/deployment/server/axis2modules ]; then
    cp -r /wso2amserver/server /wso2am/repository/deployment
fi

cp /wso2amserver/mediator/*.jar /wso2am/repository/components/lib

/bin/bash /docker-setclustermembers.sh "worker" "gatewaymanager" "gateway"

exec ./wso2server.sh "$@"