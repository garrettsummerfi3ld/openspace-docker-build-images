#!/bin/bash

args_array=("$@")
java -jar /agent.jar -jnlpUrl "${args_array[0]}" -secret "${args_array[1]}" -workDir "/var/jenkins"
