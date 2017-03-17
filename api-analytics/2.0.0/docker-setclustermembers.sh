#!/bin/bash

# parameter 1: subdomain
# parameter 2: member 1


myhost="$(hostname -i  | awk '{ print $1}')"

if [ -n "$myhost" ]; then
    echo "Host $myhost"
    xmlstarlet edit --inplace \
        -u "/axisconfig/clustering/parameter[@name='localMemberHost']" -v "$myhost" \
        -u "/axisconfig/clustering/parameter[@name='localMemberPort']" -v "4300" \
        -u "/axisconfig/clustering/parameter[@name='properties']/property[@name='subDomain']" -v "$1" \
        /wso2analytics/repository/conf/axis2/axis2.xml 
fi


mymembers1=($(nslookup tasks.$2 | grep "Address: [0-9]" | awk '{ print $2}'))
for (( i=0; i<${#mymembers1[@]}; i++ )); do
     echo "+ add member ${mymembers1[i]}"
     xmlstarlet edit --inplace \
         -s "/axisconfig/clustering/members" --type elem -n "member" -v "" \
         --var publisher '$prev' \
         -s '$publisher' --type elem -n "hostName" -v "${mymembers1[i]}" \
         -s '$publisher' --type elem -n "port" -v "4300" \
         /wso2analytics/repository/conf/axis2/axis2.xml 
done

