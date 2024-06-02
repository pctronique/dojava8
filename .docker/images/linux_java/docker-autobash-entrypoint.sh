#!/bin/bash

if [ -z ${GCC_FOLDER_PROJECT} ]
then
    GCC_FOLDER_PROJECT=/home/project/
fi

if [ -z ${PHP_FOLDER_LOG} ]
then
    GCC_FOLDER_LOG=/var/log/docker/gcc/
fi

if [ -z ${VALUE_JAVA_VERSION} ]
then
    VALUE_JAVA_VERSION=21
fi

cp -r /usr/lib/jvm/java-${VALUE_JAVA_VERSION}-openjdk-amd64/ /jvm

touch ${GCC_FOLDER_LOG}/error.log
service startautobash start && tail -F ${GCC_FOLDER_LOG}/error.log &

exec "$@"