#include "com_example_jni_HelloWorldServiceNative.h"

#include <string>

/*
 * Class:     com_example_jni_HelloWorldServiceNative
 * Method:    getName
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_com_example_jni_HelloWorldServiceNative_getName
  (JNIEnv *env, jobject)
{
  std::string name {"Hello from c++"};
  return env->NewStringUTF(name.c_str());
}
