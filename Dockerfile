FROM maven:3.8.7 AS build
WORKDIR /app
COPY . .
# Build the application with maven
RUN mvn -B clean package -DskipTests

# Create a new image with the jar file.
FROM openjdk:17
WORKDIR /app

COPY --from=build /app/target/*.jar airruppies.jar

ENV SERVER_PORT=8282

CMD ["java", "-jar", "airruppies.jar"]