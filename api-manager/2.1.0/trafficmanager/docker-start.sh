#!/bin/bash

/bin/bash /docker-setOSConfig.sh

/bin/bash /docker-setcertificates.sh

/bin/bash /docker-setadminpassword.sh

/bin/bash /docker-setanalytics.sh

/bin/bash /docker-setdatabasepassword.sh

/bin/bash /docker-setdatabasename.sh

exec ./wso2server.sh "$@"