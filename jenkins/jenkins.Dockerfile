ARG IMAGE
FROM ${IMAGE}

RUN apt-get install -y openjdk-17-jre
RUN wget http://dev.openspaceproject.com/jnlpJars/agent.jar -q -O /agent.jar
RUN mkdir /var/jenkins
COPY data/jenkins.sh /

ARG COMPUTER_NAME
ARG SECRET
ENTRYPOINT [ "/jenkins.sh", "${COMPUTER_NAME}", "${SECRET}" ]
