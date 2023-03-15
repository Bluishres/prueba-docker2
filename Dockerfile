#
# Build stage, o fase build, donde le diremos a docker que compile nuestra API con maven.
#
FROM maven:3.6.0-jdk-8-slim AS build
COPY src ./src
COPY pom.xml ./
RUN mvn -f ./pom.xml clean package -Dmaven.test.skip=true

#
# Package stage, o fase de empaquetamiento, donde moveremos el .jar generado previamente al contenedor de docker hub,
# y le diremos con "ENTRYPOINT" el comando a ejecutyar cuando el contenedor este activo.
#
FROM openjdk:8
COPY --from=build ./target/*.jar ./app.jar
EXPOSE 8080
ENV PORT 8080
ENTRYPOINT ["java","-jar","./app.jar"]
