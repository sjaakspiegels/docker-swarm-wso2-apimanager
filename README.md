This repository contains all the dockerfiles and scripts to set up the Wso2 api manager in docker swarm mode.

There are other initiatives to run the Wso2 api manager in docker. But these solutions miss the strong point of docker.
This is running small containers instead of running all the functionality in one large container.

The following components are containarized to make the gateway running in a docker swarm:
- Publisher
- Store
- Gateway
- Gateway manager
- Identity server
- Analytics server

There are two supporting containers. These containers are used to change the configuration
