# For Java 8, try this
# FROM openjdk:8-jdk-alpine

#
# Build stage, o fase build, donde le diremos a docker que compile nuestra API con maven.
#
FROM maven:3.8.0-jdk-11-slim AS build
RUN mvn -f ./pom.xml clean package -Dmaven.test.skip=true

# For Java 11, try this
FROM openjdk:11

COPY target/spring-boot-web.jar spring-boot-web.jar

ENTRYPOINT ["java","-jar","/spring-boot-web.jar"]

## sudo docker run -p 8080:8080 -t docker-spring-boot:1.0
## sudo docker run -p 80:8080 -t docker-spring-boot:1.0
## sudo docker run -p 443:8443 -t docker-spring-boot:1.0
