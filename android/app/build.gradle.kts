plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Firebase Google Services
}
apply(plugin = "com.google.gms.google-services")
android {
    namespace = "com.example.my_assignmentt"
    compileSdk = 34 // Latest stable version
    ndkVersion = "26.1.10909125"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true // Enable Java 8+ desugaring
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.my_assignmentt"
        minSdk = 23
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // AndroidX Core
    implementation("androidx.core:core-ktx:1.12.0")

    // Firebase Messaging (Push Notifications)
    implementation("com.google.firebase:firebase-messaging-ktx:23.3.1")

    // Core Library Desugaring (Java 8+ Features)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // Glide (For Image Loading)
    implementation("com.github.bumptech.glide:glide:4.16.0")

    // WorkManager (For Background Tasks)
    implementation("androidx.work:work-runtime-ktx:2.9.0")

    // Local Notifications
    implementation("com.google.android.gms:play-services-location:21.0.1")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
}
