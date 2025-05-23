FROM openjdk:17-jdk-alpine
RUN apk add --no-cache bash
WORKDIR /app

# On attend que le build Maven ait généré ce .jar manuellement en dehors de Docker
COPY ./target/E-Commerce-0.0.1-SNAPSHOT.jar /app.jar
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

ENTRYPOINT ["/wait-for-it.sh", "mysql-db-mono:3306", "-t", "60", "--", "java", "-jar", "/app.jar"]
