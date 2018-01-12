# FROM maven:3.5.2-jdk-8-alpine
FROM maven:3-jdk-8-alpine

RUN mkdir -p /workspace /var/local/cas/logs

ARG USER_UID
RUN adduser -D -g '' -u $USER_UID user && chown -R user /workspace /var/local/cas

USER user

WORKDIR /workspace

ADD pom.xml /workspace/
ADD src /workspace/src

CMD cd /workspace && mvn package && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar target/*.war

