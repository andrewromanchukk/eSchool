FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN ls
ARG DATASOURCE_URL
ARG DATASOURCE_USERNAME
ARG DB_PASSWORD
RUN sed -i -e "s|localhost|${DATASOURCE_URL}|g"  /tmp/src/main/resources/application.properties
RUN sed -i -e "s|DATASOURCE_USERNAME:root|DATASOURCE_USERNAME:${DATASOURCE_USERNAME}|g"  /tmp/src/main/resources/application.properties
RUN sed -i -e "s|DATASOURCE_PASSWORD:root|DATASOURCE_PASSWORD:${DATASOURCE_PASSWORD}|g"  /tmp/src/main/resources/application.properties
RUN mvn package -DskipTests
RUN cat /tmp/src/main/resources/application.properties

FROM openjdk:8-jdk-alpine
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/eschool.jar eschool.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "eschool.jar"]