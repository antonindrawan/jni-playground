#! /usr/bin/env bash

mkdir -p output

# This is an example of raw commands to generate JNI stub.
# They can also be invoked from CMake using add_jar to compile Java files and add_custom_command to trigger javac.
#  $ javac -d output src/com/example/jni/HelloWorldServiceNative.java
#  $ javah -d output -classpath bin -jni com.example.jni.HelloWorldServiceNative

pushd output
  cmake -G Ninja .. && ninja
popd

# Run the example app that uses the Native jar. Note: It can be done from CMake.
java -Djava.library.path=output/ -cp output/HelloWorldService.jar:output/HelloWorldServiceNative.jar com.example.jni.HelloWorldService
