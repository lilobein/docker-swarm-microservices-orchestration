FROM openjdk:8u201-jdk-alpine3.9 AS build
RUN addgroup -g 1000 -S appgroup && adduser -u 1000 -S appuser -G appgroup
WORKDIR /app/
RUN mkdir -p /app/target && chown -R appuser:appgroup /app
COPY --chown=appuser:appgroup pom.xml mvnw ./
COPY --chown=appuser:appgroup .mvn .mvn
RUN chmod +x mvnw
USER appuser
RUN ./mvnw -B dependency:go-offline
COPY --chown=appuser:appgroup src src
RUN ./mvnw package -DskipTests

FROM openjdk:8u212-jre-alpine3.9
RUN addgroup -g 1000 -S appgroup && adduser -u 1000 -S appuser -G appgroup
WORKDIR /app/
USER root
RUN apk add --no-cache bash
RUN mkdir -p /app && chown -R appuser:appgroup /app
COPY --from=build --chown=appuser:appgroup /app/target/*.jar app.jar
COPY --chown=appuser:appgroup wait-for-it.sh .
RUN chmod +x wait-for-it.sh
USER appuser
ENTRYPOINT ["./wait-for-it.sh", "database-service:5432", "-t", "60", "--", "java", "-jar", "app.jar"]