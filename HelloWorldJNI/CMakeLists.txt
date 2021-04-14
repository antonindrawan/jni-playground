cmake_minimum_required(VERSION 3.0)

project(HelloWorldJNI LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)

find_package(JNI REQUIRED)
find_package(Java REQUIRED)
include(UseJava)

add_jar(HelloWorldService
    src/com/example/jni/HelloWorldServiceNative.java
    src/com/example/jni/HelloWorldService.java
)

# Generate JNI header stub
set (_stubDir "${CMAKE_CURRENT_BINARY_DIR}")
add_custom_command(
  OUTPUT com_example_jni_HelloWorldServiceNative.h
  COMMAND ${Java_JAVAC_EXECUTABLE}
      -h ${_stubDir}
      ${PROJECT_SOURCE_DIR}/src/com/example/jni/HelloWorldServiceNative.java
)

# Compile JNI
add_library(HelloWorldJNI MODULE
  jni/HelloWorldService.cpp
  ${_stubDir}/com_example_jni_HelloWorldServiceNative.h
)

target_include_directories(HelloWorldJNI
  PUBLIC
    ${JNI_INCLUDE_DIRS}
    ${_stubDir}
)