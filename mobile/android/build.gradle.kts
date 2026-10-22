// Root build script for Android module – using default build directories.

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Register a clean task that deletes the project's build directory.
tasks.register<Delete>("clean") {
    delete(layout.buildDirectory)
}
