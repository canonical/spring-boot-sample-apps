FROM gradle:jdk11 AS build

COPY . /build

WORKDIR /build

RUN ./gradlew build

FROM eclipse-temurin:11-jdk-jammy

RUN adduser --system --no-create-home --disabled-login --group spring-boot

USER spring-boot

COPY --from=build --chown=spring-boot:spring-boot /build/build/libs/sample-app-0.0.1-SNAPSHOT.jar /app/sample-app-0.0.1-SNAPSHOT.jar

WORKDIR /app

HEALTHCHECK --timeout=1s CMD curl -sSf http://127.0.0.1:8080/actuator/health

CMD ["java", "-jar", "sample-app-0.0.1-SNAPSHOT.jar"]
