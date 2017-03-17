FROM openjdk:alpine
MAINTAINER Sjaak

RUN mkdir certificates

VOLUME certificates

COPY ./docker-start.sh /
RUN chmod +x /docker-start.sh

ENTRYPOINT ["sh",  "/docker-start.sh"]

