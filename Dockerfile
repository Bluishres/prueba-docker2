# For Java 8, try this
# FROM openjdk:8-jdk-alpine

#
# Build stage, o fase build, donde le diremos a docker que compile nuestra API con maven.
#
FROM maven:3.6.0-jdk-8-slim AS build
COPY src ./src
COPY pom.xml ./
RUN mvn -f ./pom.xml clean package -Dmaven.test.skip=true

# For Java 11, try this
FROM openjdk:8-jdk-alpine

# Refer to Maven build -> finalName
ARG JAR_FILE=target/spring-boot-web.jar

# cd /opt/app
WORKDIR /opt/app

# cp target/spring-boot-web.jar /opt/app/app.jar
COPY ${JAR_FILE} app.jar

# java -jar /opt/app/app.jar
ENTRYPOINT ["java","-jar","app.jar"]

## sudo docker run -p 8080:8080 -t docker-spring-boot:1.0
## sudo docker run -p 80:8080 -t docker-spring-boot:1.0
## sudo docker run -p 443:8443 -t docker-spring-boot:1.0
