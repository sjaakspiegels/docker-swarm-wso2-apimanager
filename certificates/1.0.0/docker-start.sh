#!/bin/bash

cd /certificates
rm wso2*

keytool -genkey -alias wso2storecert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=store.wso2" -validity 18263 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2store.jks -storepass wso2carbon
keytool -export -alias wso2storecert -keystore wso2store.jks -storepass wso2carbon -file wso2store.pem 

keytool -genkey -alias wso2gatewaymanagercert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=gatewaymanager.wso2" -validity 18263 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2gatewaymanager.jks -storepass wso2carbon 
keytool -export -alias wso2gatewaymanagercert -keystore wso2gatewaymanager.jks -storepass wso2carbon -file wso2gatewaymanager.pem 

keytool -genkey -alias wso2gatewaycert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=gateway.wso2" -validity 18263 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2gateway.jks -storepass wso2carbon 
keytool -export -alias wso2gatewaycert -keystore wso2gateway.jks -storepass wso2carbon -file wso2gateway.pem 

keytool -genkey -alias wso2keymanagercert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=keymanager.wso2" -validity 18263 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2keymanager.jks -storepass wso2carbon 
keytool -export -alias wso2keymanagercert -keystore wso2keymanager.jks -storepass wso2carbon -file wso2keymanager.pem 

keytool -genkey -alias wso2publishercert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=publisher.wso2" -validity 18263 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2publisher.jks -storepass wso2carbon 
keytool -export -alias wso2publishercert -keystore wso2publisher.jks -storepass wso2carbon -file wso2publisher.pem 

keytool -genkey -alias wso2trafficmanagercert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=trafficmanager.wso2" -validity 18263 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2trafficmanager.jks -storepass wso2carbon 
keytool -export -alias wso2trafficmanagercert -keystore wso2trafficmanager.jks -storepass wso2carbon -file wso2trafficmanager.pem 

keytool -genkey -alias wso2dascert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=das.wso2" -validity 36500 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2das.jks -storepass wso2carbon 
keytool -export -alias wso2dascert -keystore wso2das.jks -storepass wso2carbon -file wso2das.pem 

keytool -genkey -alias wso2identityservercert -dname "C=NL,ST=ZH,L=Netherlands,O=WSO2,OU=Carbon,CN=identityserver.wso2" -validity 18263 \
        -keyalg RSA -keysize 4096 -keypass wso2carbon -keystore wso2identityserver.jks -storepass wso2carbon 
keytool -export -alias wso2identityservercert -keystore wso2identityserver.jks -storepass wso2carbon -file wso2identityserver.pem 