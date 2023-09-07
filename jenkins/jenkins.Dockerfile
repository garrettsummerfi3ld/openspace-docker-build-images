ARG IMAGE
FROM ${IMAGE}

RUN apt-get install -y openjdk-17-jre
RUN wget http://dev.openspaceproject.com/jnlpJars/agent.jar -q -O /agent.jar
RUN mkdir /var/jenkins

# We have to go this roundabout way as we cannot use ARG inside an ENTRYPOINT
ARG COMPUTER_NAME
ENV computer_name=$COMPUTER_NAME

ARG SECRET
ENV secret=$SECRET

# We also cannot use the array form of ENTRYPOINT as we need the shell to expand the environment variables
ENTRYPOINT java -jar /agent.jar -jnlpUrl http://dev.openspaceproject.com/computer/$computer_name/jenkins-agent.jnlp -secret $secret -workDir /var/jenkins