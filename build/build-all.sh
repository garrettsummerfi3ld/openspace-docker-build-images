#!/bin/bash
# Build all containers in this folder. The tag is "openspace-" followed by the name of
# the Dockerfile without the file extension
for f in *.Dockerfile; do
  echo "Building $f"
  docker build --tag "openspace-${f%.Dockerfile}" --file "$f" .
done
