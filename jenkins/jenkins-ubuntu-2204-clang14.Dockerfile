FROM alexanderbock/openspace-compilation:ubuntu2204-clang14

RUN apt-get install -y openjdk-17-jre
RUN wget http://dev.openspaceproject.com/jnlpJars/agent.jar -q -O /agent.jar

RUN mkdir /var/jenkins

COPY jenkins.sh /
# ENTRYPOINT [ "/jenkins.sh" ]
