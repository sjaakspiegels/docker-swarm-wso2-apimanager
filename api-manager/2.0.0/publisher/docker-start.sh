#!/bin/bash

/bin/bash /docker-setOSConfig.sh

/bin/bash /docker-setcertificates.sh

/bin/bash /docker-setadminpassword.sh

/bin/bash /docker-setanalytics.sh

/bin/bash /docker-setdatabasepassword.sh

/bin/bash /docker-setdatabasename.sh

cp /wso2amserver/mediator/*.jar /wso2am/repository/components/lib

/bin/bash /docker-setclustermembers.sh "worker" "publisher" "store"

exec ./wso2server.sh "$@"