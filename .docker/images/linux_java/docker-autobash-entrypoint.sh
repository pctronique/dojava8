#!/bin/bash

if [ -z ${JAVA_FOLDER_PROJECT} ]
then
    JAVA_FOLDER_PROJECT=/home/project/
fi

if [ -z ${PHP_FOLDER_LOG} ]
then
    JAVA_FOLDER_LOG=/var/log/java/
fi

if [ -z ${VALUE_JAVA_VERSION} ]
then
    VALUE_JAVA_VERSION=21
fi

cp -r /usr/lib/jvm/java-${VALUE_JAVA_VERSION}-openjdk-amd64/ /jvm

touch ${JAVA_FOLDER_LOG}/error.log
service startautobash start && tail -F ${JAVA_FOLDER_LOG}/error.log &

exec "$@"
