FROM openjdk:8u201-jdk-alpine3.9 AS build
WORKDIR /app/
COPY pom.xml mvnw ./
COPY .mvn .mvn

RUN ./mvnw -B dependency:go-offline

COPY src src
RUN ./mvnw package -DskipTests

FROM openjdk:8u212-jre-alpine3.9
WORKDIR /app/
RUN apk add --no-cache bash 
COPY --from=build /app/target/*.jar app.jar
COPY wait-for-it.sh .
ENTRYPOINT ["bash", "-c", "./wait-for-it.sh database-service:5432 -t 60 && java -jar app.jar"]
