buildscript {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal() // Ensures Gradle plugins can be resolved
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.2.0") // Android Gradle Plugin
        classpath("com.google.gms:google-services:4.4.0") // Google Services
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
