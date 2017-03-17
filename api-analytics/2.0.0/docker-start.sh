#!/bin/bash

/bin/bash /docker-setOSConfig.sh

/bin/bash /docker-setbatchschedules.sh

/bin/bash /docker-setdatabasepassword.sh

/bin/bash /docker-setdatabasename.sh

/bin/bash /docker-setcertificates.sh

/bin/bash /docker-setadminpassword.sh

/bin/bash /docker-setclustermembers.sh "worker" "das"

exec ./wso2server.sh