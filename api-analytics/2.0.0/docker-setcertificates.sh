#!/bin/bash

cp /certificates/* /wso2analytics/repository/resources/security
cd /wso2analytics/repository/resources/security

# Add public key to client-truststore
keytool -import -alias wso2storecert -file wso2store.pem \
        -keystore client-truststore.jks -storepass wso2carbon -noprompt

keytool -import -alias wso2gatewaymanagercert -file wso2gatewaymanager.pem \
        -keystore client-truststore.jks -storepass wso2carbon -noprompt

keytool -import -alias wso2gatewaycert -file wso2gateway.pem \
        -keystore client-truststore.jks -storepass wso2carbon -noprompt

keytool -import -alias wso2keymanagercert -file wso2keymanager.pem \
        -keystore client-truststore.jks -storepass wso2carbon -noprompt

keytool -import -alias wso2publishercert -file wso2publisher.pem \
        -keystore client-truststore.jks -storepass wso2carbon -noprompt

keytool -import -alias wso2trafficmanagercert -file wso2trafficmanager.pem \
        -keystore client-truststore.jks -storepass wso2carbon -noprompt

keytool -import -alias wso2dascert -file wso2das.pem \
       -keystore client-truststore.jks -storepass wso2carbon -noprompt 

keytool -import -alias wso2identityservercert -file wso2identityserver.pem \
       -keystore client-truststore.jks -storepass wso2carbon -noprompt            