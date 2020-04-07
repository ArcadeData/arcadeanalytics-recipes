#!/usr/bin/env bash

shopt -s extglob

set -x
local_path="$(cd "$( dirname "$0" )" && pwd)"

maven_base_url=https://repo1.maven.org/maven2/com/arcadeanalytics

arcade_path=./arcade-single-war

arcade_ver=1.0.5
#prod will use postgres and elastic standalone
arcade_profiles=prod
#prod will h2db and elastic embedded
#arcade_profiles=prod-single

connectors_path=$arcade_path/arcade-connectors
connectors_ver=1.0.10
connectors="arcade-connectors-neo4j3|arcade-connectors-orientdb3|arcade-connectors-gremlin|arcade-connectors-rdbms"

if [ ! -d  $connectors_path ]; then
  echo "create connectors dir $connectors_path"
  mkdir -p $connectors_path
fi

for connector in ${connectors//|/ }
do
  if [ ! -f "$connectors_path/$connector-$connectors_ver.jar" ]; then
    echo "--> remove prevoius version of '$connector' "
    rm $connectors_path/$connector*.jar
    echo "--> download ArcadeAnalytics '$connector'  version: $connectors_ver"
    curl -o $connectors_path/$connector-$connectors_ver.jar \
        $maven_base_url/$connector/$connectors_ver/$connector-$connectors_ver.jar
  fi
done

if [ ! -f arcadeanalytics-$arcade_ver.war ]; then
  echo "--> download ArcadeAnalytics war"
  curl -o arcadeanalytics-$arcade_ver.war \
    $maven_base_url/arcadeanalytics/$arcade_ver/arcadeanalytics-$arcade_ver.war
fi

spring_data=""
if [ $arcade_profiles == "prod" ]; then
  spring_data="--spring.datasource.url=jdbc:postgresql://localhost:5432/arcadeanalytics
      --spring.datasource.username=arcadeanalytics
      --spring.datasource.password=arcadeanalytics
      --spring.data.elasticsearch.cluster_nodes=localhhost:9300
      "
fi
java -jar  arcadeanalytics-$arcade_ver.war \
      --spring.profiles.active=$arcade_profiles   \
      $spring_data \
      --spring.email.host=smtp.gmail.com   \
      --spring.email.port=587   \
      --spring.email.username=me@mydomain.com   \
      --spring.email.password=123456   \
      --jhipster.mail.from=me@mydomain.com   \
      --jhipster.mail.base-url=http://www.myinstallaton.com/ \
      --application.path=$arcade_path \
      --application.storage.path=$arcade_path/storage \
      --application.connectorsPath=$arcade_path/arcade-connectors/ \
      --ssh.priv.key=$arcade_path/.ssh/id.rsa    \
      --ssh.pub.key=$arcade_path/.ssh/id.rsa.pub
