#/////////////////////////////////////
#//    DEVELOPPEUR : PCTRONIQUE     //
#/////////////////////////////////////

#!/bin/sh

rm -rf dist
mkdir dist
rm -rf build
mkdir build
rm -rf tmp
mkdir tmp

export JAR_NAME_PROJECT=dojava8

if [ -z ${VALUE_JAVA_VERSION} ]
then
    VALUE_JAVA_VERSION=8
fi

if [ -z ${JAVA_FOLDER_PROJECT} ]
then
    JAVA_FOLDER_PROJECT=${0%/*}/
fi

if [ -z ${MANI_FOLDER} ]
then
    MANI_FOLDER=${JAVA_FOLDER_PROJECT}/tmp
fi

cd ${JAVA_FOLDER_PROJECT}

mkdir -p ${MANI_FOLDER}

LIST_LIB_JAR=$(find -L lib -name "*.jar")
LIST_LIB_JAR=$(echo ${LIST_LIB_JAR})
LIST_ALL_JAVA=$(find -L src -name "*.java")
LIST_ALL_JAVA=$(echo ${LIST_ALL_JAVA})

IFS=' ' read -r -a arrayJava <<< "${LIST_ALL_JAVA}"

if [ -z ${JAVA_FILE_MAIN} ]
then
    for FILE_JAVA in "${arrayJava[@]}"
    do
        if grep -q "public static void main(" "${FILE_JAVA}"; then
            FILE_JAVA=${FILE_JAVA/src\//}
            FILE_JAVA=${FILE_JAVA/\.java/}
            FILE_JAVA=$(sed "s/\//./gm" <<< "${FILE_JAVA}")
            JAVA_FILE_MAIN=${FILE_JAVA}
        fi
    done
fi

echo "Manifest-Version: 1.0" > ${MANI_FOLDER}/MANIFEST.MF
echo "Created-By: ${VALUE_JAVA_VERSION} (Ubuntu)" >> ${MANI_FOLDER}/MANIFEST.MF
echo "Class-Path: ${LIST_LIB_JAR}" >> ${MANI_FOLDER}/MANIFEST.MF

if [ ! -z ${JAVA_FILE_MAIN} ]
then
    echo "Main-Class: ${JAVA_FILE_MAIN}" >> ${MANI_FOLDER}/MANIFEST.MF
fi

cd build
cmake ../
make
cd tmp
#zip -gr ${JAR_NAME_PROJECT}.jar resources > /tmp/zip.log
cp ${JAR_NAME_PROJECT}.jar ../../dist
cd ../..

rm -rf build
rm -rf tmp
