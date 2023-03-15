FROM openjdk
COPY ./target/SPE_MiniProject-1.0-SNAPSHOT-jar-with-dependencies.jar ./
WORKDIR ./
CMD ["java", "-jar", "SPE_MiniProject-1.0-SNAPSHOT-jar-with-dependencies.jar"]