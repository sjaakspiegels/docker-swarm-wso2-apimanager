# docker-swarm-wso2-apimanager
Wso2 api manager deployed in docker swarm mode.
This repository will describe and publish our setup of Wso2 api manager with the identity server and the analytics server in a Docker Swarm. All the Wso2 components will run in separate containers. This will increase scalability and reliability.

# Prerequisites
-	Ubuntu (16.04 or higher) or RHEL host(s)
-	Docker v1.13.1 (minimum)
    - Must run in Swarm Mode
    - overlay network Wso2 (opt --encrypted)

# Architecture of the solution
The diagram clarifies the architecture of wso2 docker solution.
![stackflow](https://github.com/sjaakspiegels/docker-swarm-wso2-apimanager/blob/master/wso2dockerarchitecture.png)

All wso2 components will be deployed in separate containers. The containers are deployed in an overlay network named wso2. This name is fixed because the configuration depends on it. This also applies to the name of the container. These names are also fixed because of the configuration.

Persistent data is stored in a MySql database. 

The communication between the container is secure. Certificates and java key store are created with the supporting container voogd/certificates:1.0.0. When a container starts it copies the needed certificates in the wso2 security folder.

When a new api is published, the publisher sends a command to the gateway manager. The gatewaymanager stores a xml description of the api to a shared volume and signals the gateways. Triggered by these signals the gateway reads the new api definition.
In the examples given below server folder is a nfs folder locate on a server with address ip-address. 
The folder /var/dockerdata/wso2/mediator stores the mediator jar files for the gateway. In the folder /var/dockerdata/wso2/server copy of the wso2 folder /wso2am/repository/deployment/server is stored.

The publisher uses soap communication to the gatewaymanager. This works not very well with the round robin load balancer used in docker swarm. For this reason it recommended to run one gatewaymanager.

Because of the HAProxy there is no need to publish ports in the containers. The HAProxy analyses the dns name and routes the request to the right container.

The analytics server is not shown in this diagram. With an environment variable (WSO2_CARBON_ANALYTICS) in the wso2 container, sending analytics data to this server can be switch on or off.

Logging in the wso2 components is minimized and all logging is redirected to the console.

# Used components
The images of this solution follow the versioning of the wso2 components.

| Components | Version |
| ---------- | ------- |
| apigatewaymanager | 2.0.0 |
| apigateway | 2.0.0 |
| publisher	| 2.0.0 |
| store	| 2.0.0 |
| trafficmanager | 2.0.0 |
| identityserver | 5.2.0 |
| api-analytics	| 2.0.0 |

# Setup containers
The following containers are used to configure the Wso2 configuration.

| Container	| Description |
| --------- | ----------- |
| changeadminpassword	| Changes the admin password of the administrator in the database. This feature can be used when a production database is copied to test or development. |
| certificates | Generates the certificates used for the communication between the different Wso2 components. |

# Preparation
## Docker
```
$ docker swarm init
$ docker network create -d overlay wso2
```

## MySql database
For data persistence the standard MySql 5.7 image is used.
In this example the data for the MySql database is located in /var/dockerdata/wso2/mysql. Copy the folder mysql/conf.d and mysql/initdb.d to /var/dockerdata/wso2/mysql/conf.d and /var/dockerdata/wso2/mysql/initdb.d. After this copy the MySql container is ready to be started.
```
$ docker service create -–name mysql –p 3306:3306 -–network=wso2 \
–e MYSQL_ROOT_PASSWORD=Wso2 \
-–mount type=bind,source=/var/dockerdata/wso2/mysql/conf.d,target=/etc/mysql/conf.d \
--mount type=bind,source=/var/dockerdata/wso2/mysql/data,target=/var/lib/mysql \
--constraint "node.role==manager" mysql:5.7
```

## HAProxy
A reverse proxy is needed to route traffic to the different services of Wso2. For this setup HAProxy is used. In this example the certificates for the proxy are stored in /var/dockerdata/haproxy/certs.
```
$ docker service create -–name haproxy -–network=wso2 \
-–mount target=/var/run/docker.sock,source=/var/run/docker.sock,type=bind \
-p 80:80 –p 443:443 –p 1936:1936 \
-e CERT_FOLDER="/certs/" \
--mount source=/var/dockerdata/haproxy/certs,target=/certs,type=bind \
--constraint "node.role==manager" dockercloud/haproxy 
```

Because a reverse proxy is used, it is necessary to create DNS entries for the wso2 components. In this example the domain is set to local.com. The following DNS entries must all reference to docker swarm leader.

| DNS Entries |
| ----------- |
| Identityserver.local.com |
| Trafficmanager.local.com |
| Store.local.com |
| Publisher.local.com |
| Gatewaymanager.local.com |
| Gateway.local.com |

The names given assigned to the wso2 components can not be changed. In the wso2 configuration (docker-files) the containers do reference the other components on this name and the wso2 domain. Because the components are distributed over different swarm nodes using volumes, it is neccesary to use a nfs configuration. In the examples below the variable ip-address must be replaced with the ip-address of the host where the nfs share is running.

## Certificates
The image certificates is used to create the certificates for the intercontainer communication between the Wso2 components. With the following command the certificates are generated and placed in the folder /var/dockerdata/wso2/certificates.
```
$ docker run –-rm \
–v /var/dockerdata/wso2/certificates:/certificates voogd/wso2-certificates:1.0.0 
```

At start up the Wso2 components will copy the needed certificates in their private java key store.

# WSO2 configuration variables
With the following environment variables the configuration of the WSO2 containers can be changed.

| Variable | Description |
| -------- | ----------- |
| VIRTUAL_HOST | DNS name of the service. This name is used by HAProxy. |
| SERVICE_PORTS | This port is used by HAProxy to communicate to the container. |
| EXTRA_ROUTE_SETTING | Route setting used by HAProxy to access the container. |
| WSO2_ADMIN_PASSWORD | Password of the WSO2 administrator. This password is use for communication between WSO2 containers. With the container changeadminpassword this password can be changed. |
| WSO2_MYSQL_PASSWORD | MySql password for the user apisqluser. |
| WSO2_DAS_APIM_INCREMENTAL_PROCESSING_SCRIPT | Cron schedule for the analytic server task. |
| WSO2_DAS_APIM_LAST_ACCESS_TIME_SCRIPT | Cron schedule for the analytic server task. |
| WSO2_DAS_APIM_LATENCY_BREAKDOWN_STATS | Cron schedule for the analytic server task. |
| WSO2_DAS_APIM_LOGANALYZER_SCRIPT | Cron schedule for the analytic server task. |
| WSO2_DAS_APIM_STAT_SCRIPT | Cron schedule for the analytic server task. |
| WSO2_DAS_APIM_STAT_SCRIPT_THROTTLE | Cron schedule for the analytic server task. |
| WSO2_DAS_APIM_USER_AGENT_STATS | Cron schedule for the analytic server task. |
| WSO2_CARBON_ANALYTICS | Enable or disable send analytics information to the analytic server. |

## Api analytics server
```
$ docker service create --name=das --network=wso2 \
-e VIRTUAL_HOST="https://das.local.com" \
-e SERVICE_PORTS="9443" \
-e EXTRA_ROUTE_SETTING="ssl verify nocache" \
-e WSO2_ADMIN_PASSWORD="admin" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
-e WSO2_DAS_APIM_INCREMENTAL_PROCESSING_SCRIPT="0 0/2 * 1/1 * ?" \
-e WSO2_DAS_APIM_LAST_ACCESS_TIME_SCRIPT="0 1/15 * 1/1 * ? *" \
-e WSO2_DAS_APIM_LATENCY_BREAKDOWN_STATS="0 5/15 * 1/1 * ? *" \
-e WSO2_DAS_APIM_LOGANALYZER_SCRIPT="0 0/15 * 1/1 * ? 2030" \
-e WSO2_DAS_APIM_STAT_SCRIPT="0 9/15 * 1/1 * ? *" \
-e WSO2_DAS_APIM_STAT_SCRIPT_THROTTLE="0 0/5 * 1/1 * ? 2030" \
-e WSO2_DAS_APIM_USER_AGENT_STATS="0 11/15 * 1/1 * ? *" \
--mount type=volume,volume-opt=o=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 sspiegels/wso2-analytics:2.0.0
```

## Identity server
```
$ docker service create --name=identityserver --network=wso2 \
-e VIRTUAL_HOST="https:// identityserver.local.com" \
-e SERVICE_PORTS="9443" \
-e EXTRA_ROUTE_SETTINGS="ssl verify none" \
-e COOKIE="SRV insert indirect nocache" \
-e WSO2_ADMIN_PASSWORD="admin" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
-e WSO2_CARBON_ANALYTICS="true" \
--mount type=volume,volume-opt=o=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 sspiegels/wso2-identityserver:5.2.0
```

## Publisher
```
$ docker service create --name=publisher --network=wso2 \
-e VIRTUAL_HOST="https:// publisher.local.com" \
-e SERVICE_PORTS="9443" \
-e EXTRA_ROUTE_SETTINGS="ssl verify none" \
-e COOKIE="SRV insert indirect nocache" \
-e WSO2_ADMIN_PASSWORD="admin" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
-e WSO2_CARBON_ANALYTICS="true" \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/mediator,\
volume-opt=type=nfs,source=vol-wso2-mediator,target=/wso2amserver/mediator \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/server,\
volume-opt=type=nfs,source=vol-wso2-deployment-server,target=/wso2am/repository/deployment/server \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 sspiegels/wso2-publisher:2.0.0
```

## Trafficmanager
```
$ docker service create --name=trafficmanager --network=wso2 \
-e VIRTUAL_HOST="https://trafficmanager.local.com" \
-e SERVICE_PORTS="9443" -e EXTRA_ROUTE_SETTINGS="ssl verify none" \
-e COOKIE="SRV insert indirect nocache" \
-e WSO2_ADMIN_PASSWORD="admin2" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
-e WSO2_CARBON_ANALYTICS="true" \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 sspiegels/wso2-trafficmanager:2.0.0
```

## Store
```
$ docker service create --name=store --network=wso2 \
-e VIRTUAL_HOST="https://store.local.com" \
-e SERVICE_PORTS="9443" -e EXTRA_ROUTE_SETTINGS="ssl verify none" \
-e COOKIE="SRV insert indirect nocache" \
-e WSO2_ADMIN_PASSWORD="admin2" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
-e WSO2_CARBON_ANALYTICS="true" \
-e WSO2_GATEWAY_ENDPOINT="https://gateway.local.com" \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 sspiegels/wso2-store:2.0.0
```

## Gateway manager
```
$ docker service create --name=gatewaymanager --network=wso2 \
-e VIRTUAL_HOST="https://gatewaymanager.local.com" \
-e SERVICE_PORTS="9443" -e EXTRA_ROUTE_SETTINGS="ssl verify none" \
-e COOKIE="SRV insert indirect nocache" \
-e WSO2_ADMIN_PASSWORD="admin2" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
-e WSO2_CARBON_ANALYTICS="true" \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/mediator,\
volume-opt=type=nfs,source=vol-wso2-mediator,target=/wso2amserver/mediator \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/server,\
volume-opt=type=nfs,source=vol-wso2-deployment-server,target=/wso2am/repository/deployment/server \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 sspiegels/wso2-gatewaymanager:2.0.0
```

## Gateway
```
$ docker service create --name=gateway --network=wso2 \
-e VIRTUAL_HOST="https://gateway.local.com" \
-e SERVICE_PORTS="8243" -e EXTRA_ROUTE_SETTINGS="ssl verify none" \
-e COOKIE="SRV insert indirect nocache" \
-e WSO2_ADMIN_PASSWORD="admin2" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
-e WSO2_CARBON_ANALYTICS="true" \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/mediator,\
volume-opt=type=nfs,source=vol-wso2-mediator,target=/wso2amserver/mediator \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/server,\
volume-opt=type=nfs,source=vol-wso2-deployment-server,target=/wso2am/repository/deployment/server \
--mount type=volume,volume-opt=o=addr=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 2 sspiegels/wso2-gateway:2.0.0
```

# Technical background 

The dependencies between the different images can be clarified with the following tree.
    - java:1.8.0 '>' tets
    
