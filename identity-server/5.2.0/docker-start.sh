#!/bin/bash

/bin/bash /docker-setOSConfig.sh

/bin/bash /docker-setdatabasepassword.sh

/bin/bash /docker-setdatabasename.sh

/bin/bash /docker-setcertificates.sh

/bin/bash /docker-setadminpassword.sh

/bin/bash /docker-setclustermembers.sh "worker" "identityserver"

sed -i "s%\${carbon.protocol}://\${carbon.host}:\${carbon.management.port}%$VIRTUAL_HOST%g" \
    /wso2is/repository/conf/identity/identity.xml

sed -i "s%\${carbon.protocol}://\${carbon.host}:\${carbon.management.port}%$VIRTUAL_HOST%g" \
    /wso2is/repository/conf/identity/sso-idp-config.xml

sed -i "s%\https://localhost:9443%$VIRTUAL_HOST%g" \
    /wso2is/repository/conf/security/authenticators.xml

exec ./wso2server.sh