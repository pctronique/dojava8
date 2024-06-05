#!/bin/bash

if [ -z ${JAVA_FOLDER_LOG} ]
then
    JAVA_FOLDER_LOG=/var/log/docker/java/
fi

if [ -z ${VALUE_JAVA_VERSION} ]
then
    VALUE_JAVA_VERSION=8
fi

if [ -z ${JAVA_FOLDER_INIT} ]
then
    JAVA_FOLDER_INIT="/var/docker/java/"
fi

${JAVA_FOLDER_INIT}/importdata.sh 2>> ${JAVA_FOLDER_LOG}/installdata.log

${JAVA_FOLDER_INIT}/modifname.sh 2>> ${JAVA_FOLDER_LOG}/installdata.log

cp ${CRON_FOLDER_INIT}/dockercron /etc/cron.d/dockercron

crontab /etc/cron.d/dockercron

#while inotifywait -e close_write /etc/cron.d/dockercron; do crontab /etc/cron.d/dockercron; done &

crontab /etc/cron.d/dockercron

${CRON_FOLDER_INIT}/cronauto.sh 2>> ${JAVA_FOLDER_LOG}/initnodejs.log &

touch ${JAVA_FOLDER_LOG}/cron.log
cron && tail -f ${JAVA_FOLDER_LOG}/cron.log &

cp -r /usr/lib/jvm/java-${VALUE_JAVA_VERSION}-openjdk-amd64/ /jvm

touch ${JAVA_FOLDER_LOG}/error.log
service startautobash start && tail -F ${JAVA_FOLDER_LOG}/error.log &

echo "end create project" >> ${JAVA_FOLDER_LOG}/endcreate.log

exec "$@"
