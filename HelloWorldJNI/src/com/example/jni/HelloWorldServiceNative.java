package com.example.jni;

public class HelloWorldServiceNative {
    static {
        System.loadLibrary("HelloWorldJNI");
    }

    public native String getName();
}
