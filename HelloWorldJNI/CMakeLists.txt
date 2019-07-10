cmake_minimum_required(VERSION 3.0)

project(HelloWorldJNI)

set(CMAKE_CXX_STANDARD 11)

find_package(JNI REQUIRED)
find_package(Java REQUIRED)
include(UseJava)
#set(CMAKE_JAVA_COMPILE_FLAGS "-source" "1.8" "-target" "1.8")

# Compile Java files
add_jar(HelloWorldServiceNative
  src/com/example/jni/HelloWorldServiceNative.java
)

add_jar(HelloWorldService
    src/com/example/jni/HelloWorldService.java
  INCLUDE_JARS
    HelloWorldServiceNative
)

# Logging
get_target_property(_jarFile HelloWorldServiceNative JAR_FILE)
get_target_property(_classDir HelloWorldServiceNative CLASSDIR)
message(STATUS "_jarFile: ${_jarFile}")
message(STATUS "_classDir: ${_classDir}")

# Generate JNI header stub
set (_stubDir "${CMAKE_CURRENT_BINARY_DIR}")
add_custom_command(
  OUTPUT com_example_jni_HelloWorldServiceNative.h
  COMMAND ${Java_JAVAH_EXECUTABLE} -verbose
      -classpath ${_classDir}
      -d ${_stubDir}
      -jni com.example.jni.HelloWorldServiceNative
  DEPENDS HelloWorldServiceNative
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
