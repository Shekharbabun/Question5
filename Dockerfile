FROM maven:amazoncorretto as build
WORKDIR /javaapp
COPY . .
RUN mvn clean install


