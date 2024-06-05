#!/bin/bash

if [ -z ${JAVA_FOLDER_PROJECT} ]
then
    JAVA_FOLDER_PROJECT=/home/project/
fi

if [ -z ${JAVA_FOLDER_LOG} ]
then
    JAVA_FOLDER_LOG=/var/log/docker/java/
fi

if [ -z ${JAVA_FOLDER_DATA} ]
then
    JAVA_FOLDER_DATA=data
fi

if [ -z ${JAVA_FOLDER_INIT_DATA} ]
then
    JAVA_FOLDER_INIT_DATA=/docker-entrypoint-initdata.d/
fi

if [ ! -d "${JAVA_FOLDER_PROJECT}/${JAVA_FOLDER_DATA}" ]; then
    if [ ! -z "$(ls -A ${JAVA_FOLDER_INIT_DATA})" ]; then
        mkdir -p "${JAVA_FOLDER_PROJECT}/${JAVA_FOLDER_DATA}" 2>> ${JAVA_FOLDER_LOG}/installdata.log
        cp -r ${JAVA_FOLDER_INIT_DATA}/* "${JAVA_FOLDER_PROJECT}/${JAVA_FOLDER_DATA}/" 2>> ${JAVA_FOLDER_LOG}/installdata.log
        chmod 777 -R "${JAVA_FOLDER_PROJECT}/${JAVA_FOLDER_DATA}"
    fi
fi

exit 0
