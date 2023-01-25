FROM gradle:jdk11 AS build

COPY . /build

WORKDIR /build

RUN ./gradlew bootJar

FROM eclipse-temurin:11-jdk-jammy

ARG version=2.7

RUN adduser --system --no-create-home --disabled-login --group spring-boot

USER spring-boot

COPY --from=build --chown=spring-boot:spring-boot /build/build/libs/sample-app-*.jar /app/

WORKDIR /app

HEALTHCHECK --timeout=1s CMD curl -sSf http://127.0.0.1:8080/actuator/health

CMD ["java", "-jar", "sample-app-spring-boot-${version}-0.0.1-SNAPSHOT.jar"]
