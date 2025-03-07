# Stage 1: Build the application with Java 17
FROM openjdk:17-jdk-alpine AS build
WORKDIR /app
COPY . .
RUN apk add --no-cache maven && mvn clean package -DskipTests

# Stage 2: Run the application with Java 17
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/timesheet-devops-1.0.jar timesheet-devops-1.0.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "timesheet-devops-1.0.jar"]