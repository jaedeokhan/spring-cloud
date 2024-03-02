FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/discoveryservice-1.0.jar discoveryservice.jar
ENTRYPOINT ["java", "-jar", "discoveryservice.jar"]