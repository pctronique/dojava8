#/////////////////////////////////////
#//    DEVELOPPEUR : PCTRONIQUE     //
#/////////////////////////////////////

#!/bin/sh

cd ${0%/*}

rm -rf dist
mkdir dist
rm -rf build
mkdir build
rm -rf tmp
mkdir tmp

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

while read line  
do
    if [[ (! $line =~ ^#.*) && ($line =~ .*=.*) ]]; then
        export "$line"
    fi
done < ${0%/*}/.env

mkdir -p ${MANI_FOLDER}

LIST_LIB_JAR=$(find -L lib -name "*.jar")
LIST_LIB_JAR=$(echo ${LIST_LIB_JAR})
LIST_ALL_JAVA=$(find -L src -name "*.java")
LIST_ALL_JAVA=$(echo ${LIST_ALL_JAVA})

if [ ! -z ${JAR_NAME_SPLASHSCREEN} ]
then
    FIND_SPLASHSCREEN=$(find -L . -name "${JAR_NAME_SPLASHSCREEN}")
    FIND_SPLASHSCREEN=$(echo ${FIND_SPLASHSCREEN})
fi

IFS=' ' read -r -a arrayJava <<< "${LIST_ALL_JAVA}"

if [ -z ${JAVA_CLASS_MAIN} ]
then
    for FILE_JAVA in "${arrayJava[@]}"
    do
        if grep -q "public static void main(" "${FILE_JAVA}"; then
            FILE_JAVA=${FILE_JAVA/src\//}
            FILE_JAVA=${FILE_JAVA/\.java/}
            FILE_JAVA=$(sed "s/\//./gm" <<< "${FILE_JAVA}")
            JAVA_CLASS_MAIN=${FILE_JAVA}
        fi
    done
fi

echo "Manifest-Version: 1.0" > ${MANI_FOLDER}/MANIFEST.MF
echo "Created-By: ${VALUE_JAVA_VERSION} (Ubuntu)" >> ${MANI_FOLDER}/MANIFEST.MF
echo "Class-Path: ${LIST_LIB_JAR}" >> ${MANI_FOLDER}/MANIFEST.MF

if [ ! -z ${JAVA_CLASS_MAIN} ]
then
    echo "Main-Class: ${JAVA_CLASS_MAIN}" >> ${MANI_FOLDER}/MANIFEST.MF
fi

if [ ! -z ${FIND_SPLASHSCREEN} ]
then
    echo "SplashScreen-Image: META-INF/${JAR_NAME_SPLASHSCREEN}" >> ${MANI_FOLDER}/MANIFEST.MF
fi

cd build
cmake ../
make
cd tmp
rm -rf /tmp/zip.log
touch /tmp/zip.log
if [ ! -z ${FIND_SPLASHSCREEN} ]
then
    mkdir -p "META-INF"
    cp "../../${JAR_NAME_SPLASHSCREEN}" "META-INF/"
    zip -gr ${JAR_NAME_EXE}.jar META-INF >> /tmp/zip.log
fi
rm resources/README.md
LIST_RESOURCES=$(find -L resources -name "*")
LIST_RESOURCES=$(echo ${LIST_RESOURCES})
if [[ ! -z ${LIST_RESOURCES} && ${LIST_RESOURCES} != "resources" ]]
then
    zip -gr ${JAR_NAME_EXE}.jar resources >> /tmp/zip.log
fi
cp ${JAR_NAME_EXE}.jar ../../dist
cd ../..

rm -rf build
rm -rf tmp
