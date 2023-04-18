#!/bin/bash
set -x 
./gradlew clean generatejooq build
myVer=(cat ./dropwizard-jooq/src/main/resources/version.properties | grep version | sed -r "s/version=(.*)/\1/")
mkdir /tmp/artifactz
mkdir /tmp/artifactz/$myVer

cp ./dropwizard-jooq/build/libs/* /tmp/artifactz/$myVer/ 
