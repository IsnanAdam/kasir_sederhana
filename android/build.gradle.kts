buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.0'
        classpath 'com.google.gms:google-services:4.4.0' // Tambahkan ini
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
