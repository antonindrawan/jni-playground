#! /usr/bin/env bash

readonly script_dir=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
readonly output_dir=${script_dir}/output


# This is an example of raw commands to generate JNI stub.
# They can also be invoked from CMake using add_jar to compile Java files and add_custom_command to trigger javac.
#
# Java 1.8 & 1.9
#  $ javac -d output src/com/example/jni/HelloWorldServiceNative.java
#  $ javah -d output -classpath bin -jni com.example.jni.HelloWorldServiceNative
# Java 1.10 or higher
#  $ javac -h output src/com/example/jni/HelloWorldServiceNative.java

cmake -S ${script_dir} -B ${output_dir}
cmake --build ${output_dir}

# Run the example app that uses the Native jar. Note: It can be done from CMake.
java -Djava.library.path=${output_dir} -cp ${output_dir}/HelloWorldService.jar:${output_dir}/HelloWorldServiceNative.jar com.example.jni.HelloWorldService
