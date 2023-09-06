#!/bin/bash

args_array=("$@")
java -jar /agent.jar -jnlpUrl "http://dev.openspaceproject.com/computer/${args_array[0]}/jenkins-agent.jnlp" -secret "${args_array[1]}" -workDir "/var/jenkins"
