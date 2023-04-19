#!/bin/bash
set -x

for fn in `cat build_versions.txt`; do
  ver1=$(echo $fn | sed -r "s/(.*):(.*)/\1/");
  echo "project.ext.dropwizardVersion=\"$ver1\"" > versions.gradle;
  ver2=$(echo $fn | sed -r "s/(.*):(.*)/\2/");
  echo "project.ext.jooqVersion=\"$ver2\"" >> versions.gradle;

  if [ "${ver1:0:1}" = "4" ]; then
    # Dropwizard 4 needs jakarta as the namespace, and jooq 3.18.3 needs java 17
    find ./dropwizard-jooq/src/main/java -type f -exec sed -i "s/javax.ws.rs.ext.Provider/jakarta.ws.rs.ext.Provider/g" {} +
    find ./drop* -type f -exec sed -i "s/javax.validation.constraints.NotNull/jakarta.validation.constraints.NotNull/g" {} +
    find ./drop* -type f -exec sed -i "s/javax.ws.rs./jakarta.ws.rs./g" {} +
    find ./dropwizard-jooq/src/main/java -type f -exec sed -i "s/javax.inject.Singleton/jakarta.inject.Singleton/g" {} +
  else
    find ./dropwizard-jooq/src/main/java -type f -exec sed -i "s/jakarta.ws.rs.ext.Provider/javax.ws.rs.ext.Provider/g" {} +
    find ./drop* -type f -exec sed -i "s/jakarta.validation.constraints.NotNull/javax.validation.constraints.NotNull/g" {} +
    find ./drop* -type f -exec sed -i "s/jakarta.ws.rs./javax.ws.rs./g" {} +
    find ./dropwizard-jooq/src/main/java -type f -exec sed -i "s/jakarta.inject.Singleton/javax.inject.Singleton/g" {} +
  fi

  if [ "${ver2:2:2}" = "18" ]; then
    sed -i "s/sourceCompatibility = \"11\"/sourceCompatibility = \"17\"/g" build.gradle
    sed -i "s/targetCompatibility = \"11\"/targetCompatibility = \"17\"/g" build.gradle
  else
    sed -i "s/sourceCompatibility = \"17\"/sourceCompatibility = \"11\"/g" build.gradle
    sed -i "s/targetCompatibility = \"17\"/targetCompatibility = \"11\"/g" build.gradle
  fi

  set -e
  if [ "$1" = "publish" ]; then
    echo "Publishing"
    ./gradlew clean generatejooq build dropwizard-jooq:publish
  else
    echo "Not publishing"
    ./gradlew clean generatejooq build
  fi
  set +e

  myVer=$(cat ./dropwizard-jooq/src/main/resources/version.properties | grep version | sed -r "s/version=(.*)/\1/")
  mkdir /tmp/artifactz
  mkdir /tmp/artifactz/$myVer

  cp ./dropwizard-jooq/build/libs/* /tmp/artifactz/$myVer/
done

