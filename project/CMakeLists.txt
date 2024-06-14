#********** start CmakeLists.txt **********

cmake_minimum_required(VERSION 3.5)

project(PROJECT_JAVA)

#set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_BUILD_TYPE Release)

find_package(Java 1.8)
include(UseJava)

file(GLOB_RECURSE java_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/src/*.java)
file(GLOB lib_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/lib/*.jar)

set(JAR_NAME $ENV{JAR_NAME_EXE})
set(JAVA_SOURCE_FILES ${java_SRCS})
add_jar(${JAR_NAME} SOURCES ${JAVA_SOURCE_FILES} INCLUDE_JARS ${lib_SRCS} ${libTomcat_SRCS} MANIFEST "${CMAKE_CURRENT_SOURCE_DIR}/tmp/MANIFEST.MF" OUTPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build/tmp/")


file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/src/resources DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/build/tmp/)
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/lib DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/dist)

#********** end CmakeLists.txt **********
