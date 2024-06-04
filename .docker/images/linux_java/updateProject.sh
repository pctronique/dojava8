#!/bin/bash

if [ -z ${JAVA_FOLDER_PROJECT} ]
then
    JAVA_FOLDER_PROJECT=/home/project/
fi

if [ -z ${PHP_FOLDER_LOG} ]
then
    JAVA_FOLDER_LOG=/var/log/java/
fi

cd ${JAVA_FOLDER_PROJECT}

if [ -f "${JAVA_FOLDER_PROJECT}/autobash.sh" ]; then
    chmod 777 ${JAVA_FOLDER_PROJECT}/autobash.sh
    ${JAVA_FOLDER_PROJECT}/autobash.sh >> ${JAVA_FOLDER_LOG}/auto_out.log 2>> ${JAVA_FOLDER_LOG}/auto_error.log
fi
