#!/bin/bash
set -x 

for fn in `cat build_versions.txt`; do 
  ver1=$(echo $fn | sed -r "s/(.*):(.*)/\1/");
  echo "project.ext.dropwizardVersion=\"$ver1\"" > versions.gradle;
  ver2=$(echo $fn | sed -r "s/(.*):(.*)/\2/");
  echo "project.ext.jooqVersion=\"$ver2\"" >> versions.gradle;

  if [ "${ver1:0:1}" = "4" ]; then
    find ./dropwizard-jooq/src/main/java -type f -exec sed -i "s/javax.ws.rs.ext.Provider/jakarta.ws.rs.ext.Provider/g" {} +
    # find ./dropwizard-jooq/src/main/java -type f -exec sed -i "s/javax.ws.rs.core.Feature/jakarta.ws.rs.core.Feature/g" {} +
    find ./drop* -type f -exec sed -i "s/javax.validation.constraints.NotNull/jakarta.validation.constraints.NotNull/g" {} +
    find ./drop* -type f -exec sed -i "s/javax.ws.rs./jakarta.ws.rs./g" {} +
    find ./dropwizard-jooq/src/main/java -type f -exec sed -i "s/javax.inject.Singleton/jakarta.inject.Singleton/g" {} +
  fi

  ./gradlew clean generatejooq build
  myVer=$(cat ./dropwizard-jooq/src/main/resources/version.properties | grep version | sed -r "s/version=(.*)/\1/")
  mkdir /tmp/artifactz
  mkdir /tmp/artifactz/$myVer

  cp ./dropwizard-jooq/build/libs/* /tmp/artifactz/$myVer/ 
done

