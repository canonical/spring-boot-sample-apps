# Copyright 2023 Canonical Ltd.
# See LICENSE file for licensing details.

ARG jvm_version=11
ARG version=2.7

# we instanciate this env variable to be used in CMD
ENV app_version="${version}"

FROM gradle:jdk${jvm_version} AS build

COPY . /build

WORKDIR /build

RUN ./gradlew bootJar

FROM eclipse-temurin:${jvm_version}-jdk-jammy

RUN adduser --system --no-create-home --disabled-login --group spring-boot

USER spring-boot

COPY --from=build --chown=spring-boot:spring-boot /build/build/libs/sample-app-*.jar /app/

WORKDIR /app

HEALTHCHECK --timeout=1s CMD curl -sSf http://127.0.0.1:8080/actuator/health

CMD ["java", "-jar", "sample-app-spring-boot-${app_version}-0.0.1-SNAPSHOT.jar"]
