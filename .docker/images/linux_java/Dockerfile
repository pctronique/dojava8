ARG VALUE_UBUNTU_VERSION
ARG DEF_JAVA_VERSION=${VALUE_UBUNTU_VERSION:-"24.04"}

FROM ubuntu:${DEF_JAVA_VERSION}

ARG VALUE_JAVA_VERSION
ENV VALUE_JAVA_VERSION=${VALUE_JAVA_VERSION:-"8"}

ARG JAVA_FOLDER_PROJECT
ENV JAVA_FOLDER_PROJECT=${JAVA_FOLDER_PROJECT:-"/home/project/"}
ENV JAVA_FOLDER_LOG="/var/log/docker/java/"
ENV JAVA_FOLDER_TMP="/var/tmp/docker/java/"
ENV JAVA_FOLDER_INIT="/var/docker/java/"
ENV JAVA_FOLDER_INIT_DATA="/docker-entrypoint-initdata.d/"

RUN mkdir -p ${JAVA_FOLDER_PROJECT}
RUN mkdir -p ${JAVA_FOLDER_LOG}
RUN mkdir -p ${JAVA_FOLDER_TMP}
RUN mkdir -p ${JAVA_FOLDER_INIT}
RUN mkdir -p ${JAVA_FOLDER_INIT_DATA}

## APT
RUN apt-get update
RUN apt-get install -y apt-utils

## CMAKE
RUN apt-get install -y make
RUN apt-get install -y cmake
RUN apt-get install -y build-essential
RUN apt-get install -y openjdk-${VALUE_JAVA_VERSION}-jdk
RUN apt-get install -y openjdk-${VALUE_JAVA_VERSION}-jre
RUN apt-get install -y libmariadb-java
RUN apt-get install -y libjakarta-servlet-api-java
RUN apt-get install -y libmail-java
RUN apt-get install -y cron
RUN apt-get install -y unzip
RUN apt-get install -y zip

#del list
RUN rm -rf /var/lib/apt/lists/*

COPY updateProject.sh ${JAVA_FOLDER_INIT}
RUN chmod +x ${JAVA_FOLDER_INIT}/updateProject.sh

COPY docker-autobash-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-autobash-entrypoint.sh

COPY startautobash /etc/init.d/
RUN chmod +x /etc/init.d/startautobash
#RUN update-rc.d startautobash defaults

COPY dockercron ${CRON_FOLDER_INIT}
COPY dockercron /etc/cron.d/dockercron
RUN crontab /etc/cron.d/dockercron

COPY cronauto.sh ${CRON_FOLDER_INIT}
RUN chmod +x ${CRON_FOLDER_INIT}/cronauto.sh

COPY modifname.sh ${JAVA_FOLDER_INIT}
RUN chmod +x ${JAVA_FOLDER_INIT}/modifname.sh

COPY importdata.sh ${JAVA_FOLDER_INIT}
RUN chmod +x ${JAVA_FOLDER_INIT}/importdata.sh

WORKDIR ${JAVA_FOLDER_PROJECT}

ENTRYPOINT ["docker-autobash-entrypoint.sh"]

CMD /bin/bash ; sleep infinity
