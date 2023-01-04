FROM gradle:jdk11

COPY . /build

WORKDIR /build

RUN ./gradlew build

FROM openjdk:11

RUN addgroup --system spring-boot && adduser --system --no-create-home --ingroup spring-boot spring-boot

USER spring-boot

COPY --from=0 --chown=spring-boot:spring-boot /build/build/libs/sample-app-0.0.1-SNAPSHOT.jar /app/sample-app-0.0.1-SNAPSHOT.jar

WORKDIR /app

HEALTHCHECK --timeout=1s CMD curl -sSf http://127.0.0.1:8080/hello-world

CMD ["java", "-jar", "sample-app-0.0.1-SNAPSHOT.jar"]