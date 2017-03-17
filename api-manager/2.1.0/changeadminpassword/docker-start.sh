#!/bin/bash

/bin/bash /docker-setadminpassword.sh

/bin/bash /docker-setdatabasepassword.sh

/bin/bash /docker-setdatabasename.sh

/bin/bash /wso2am/bin/chpasswd.sh --db-driver "com.mysql.jdbc.Driver" \
                         --db-url "jdbc:mysql://$MYSQL_SERVERIP:3306/userdb" \
                         --db-username "apisqluser" --db-password "$WSO2_MYSQL_PASSWORD" \
                         --username "admin" --new-password "$WSO2_NEW_ADMIN_PASSWORD" 
                         

