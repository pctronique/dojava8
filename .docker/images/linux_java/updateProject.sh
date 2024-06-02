#!/bin/bash

if [ -z ${GCC_FOLDER_PROJECT} ]
then
    GCC_FOLDER_PROJECT=/home/project/
fi

if [ -z ${PHP_FOLDER_LOG} ]
then
    GCC_FOLDER_LOG=/var/log/docker/gcc/
fi

cd ${GCC_FOLDER_PROJECT}

if [ -f "${GCC_FOLDER_PROJECT}/autobash.sh" ]; then
    chmod 777 ${GCC_FOLDER_PROJECT}/autobash.sh
    ${GCC_FOLDER_PROJECT}/autobash.sh >> ${GCC_FOLDER_LOG}/auto_out.log 2>> ${GCC_FOLDER_LOG}/auto_error.log
fi