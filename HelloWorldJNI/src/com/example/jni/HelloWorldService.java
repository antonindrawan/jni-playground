package com.example.jni;

public class HelloWorldService {
    public static void main(String[] args) {
        HelloWorldServiceNative foo = new HelloWorldServiceNative();
        System.out.println("Test: " + foo.getName());
    }
}

