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
![stackflow](https://github.com/sjaakspiegels/docker-swarm-monitoring/master/wso2dockerarchitecture.png "Monitoring Logging Stack")
![alt text](https://github.com/sjaakspiegels/docker-swarm-wso2-apimanager/wso2dockerarchitecture.png)


# Used components
Used versions of Wso2 components
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
# Docker
```
$ docker swarm init
$ docker network create -d overlay wso2
```

# MySql database
For data persistence we used the standard MySql 5.7 image.
In this example the data for the MySql database is located in /var/dockerdata/wso2/mysql. Copy the folder mysql/conf.d and mysql/initdb.d to /var/dockerdata/wso2/mysql/conf.d and /var/dockerdata/wso2/mysql/initdb.d. After this copy the MySql container is ready to be started.
```
$ docker service create -–name mysql –p 3306:3306 -–network=wso2 \
–e MYSQL_ROOT_PASSWORD=Wso2 \
-–mount type=bind,source=/var/dockerdata/wso2/mysql/conf.d,target=/etc/mysql/conf.d \
--mount type=bind,source=/var/dockerdata/wso2/mysql/data,target=/var/lib/mysql \
--constraint "node.role==manager" mysql:5.7
```

# HAProxy
A reverse proxy is needed to route traffic to the different services of Wso2. For this setup HAProxy is used. In this example the certificates for the proxy are stored in /var/dockerdata/haproxy/certs.
```
$ docker service create -–name haproxy -–network=wso2 \
-–mount target=/var/run/docker.sock,source=/var/run/docker.sock,type=bind \
-p 80:80 –p 443:443 –p 1936:1936 \
-e CERT_FOLDER="/certs/" \
--mount source=/var/dockerdata/haproxy/certs,target=/certs,type=bind \
--constraint "node.role==manager" dockercloud/haproxy 
```

# Certificates
The image certificates is used to create the certificates for the intercontainer communication between the Wso2 components. With the following command the certificates are generated and placed in the folder /var/dockerdata/wso2/certificates.
```
$ docker run –-rm \
–v /var/dockerdata/wso2/certificates:/certificates Voogd/wso2-certificates:1.0.0 
```

At start up the Wso2 components will copy the needed certificates in their private java key store.

# Running the Wso2 components
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

## Api analytics server
```
$ docker service create --name=das --network=wso2 \
-e VIRTUAL_HOST="https://das.local.com" \
-e SERVICE_PORTS="9443" \
-e EXTRA_ROUTE_SETTING="ssl verify nocache" \
-e WSO2_ADMIN_PASSWORD="admin" \
-e WSO2_MYSQL_PASSWORD="AY9VYj74L3FB" \
-e WSO2_MYSQL_SERVER="mysql" \
--mount type=volume,volume-opt=o=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 voogd/wso2-identityserver
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
--mount type=volume,volume-opt=o=addr=ip-address,\
volume-opt=device=:/var/dockerdata/wso2/certificates,\
volume-opt=type=nfs,source=vol-wso2-certificates,target=/certificates \
--replicas 1 voogd/wso2-identityserver
```
The configuration dashboard of the identity server is accessible under address https://identityserver.local.com. 

# Traffic manager
