apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services' // Tambahkan baris ini

android {
    namespace "com.example.kasir_sederhana"
    compileSdkVersion 34

    defaultConfig {
        applicationId "com.example.kasir_sederhana"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    buildTypes {
        release {
            shrinkResources false
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation 'com.google.firebase:firebase-auth:22.3.1' // Tambahkan jika belum otomatis
    implementation 'com.google.firebase:firebase-core:21.1.1' // (opsional, tergantung modul)
}
