#!/bin/bash

# parameter 1: subdomain
# parameter 2: member 1
# parameter 3: member 2

myhost="$(hostname -i  | awk '{ print $1}')"

if [ -n "$myhost" ]; then
    echo "Host $myhost"
    xmlstarlet edit --inplace \
        -u "/axisconfig/clustering/parameter[@name='localMemberHost']" -v "$myhost" \
        -u "/axisconfig/clustering/parameter[@name='localMemberPort']" -v "4000" \
        -u "/axisconfig/clustering/parameter[@name='properties']/property[@name='subDomain']" -v "$1" \
        /wso2am/repository/conf/axis2/axis2.xml 
fi


mymembers1=($(nslookup tasks.$2 | grep "Address: [0-9]" | awk '{ print $2}'))
for (( i=0; i<${#mymembers1[@]}; i++ )); do
     echo "+ add member ${mymembers1[i]}"
     xmlstarlet edit --inplace \
         -s "/axisconfig/clustering/members" --type elem -n "member" -v "" \
         --var publisher '$prev' \
         -s '$publisher' --type elem -n "hostName" -v "${mymembers1[i]}" \
         -s '$publisher' --type elem -n "port" -v "4000" \
         /wso2am/repository/conf/axis2/axis2.xml 
done

mymembers2=($(nslookup tasks.$3 | grep "Address: [0-9]" | awk '{ print $2}'))
for (( i=0; i<${#mymembers2[@]}; i++ )); do
     echo "+ add member ${mymembers2[i]}"
     xmlstarlet edit --inplace \
          -s "/axisconfig/clustering/members" --type elem -n "member" -v "" \
          --var store '$prev' \
          -s '$store' --type elem -n "hostName" -v "${mymembers2[i]}" \
          -s '$store' --type elem -n "port" -v "4000" \
          /wso2am/repository/conf/axis2/axis2.xml 
done