# Flutter/Engine keep rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.android.** { *; }
-keep class io.flutter.plugins.** { *; }

# Play Core (used by Flutter for app updates, dynamic delivery)
-keep class com.google.android.play.core.** { *; }

# Supabase - keep all classes in case reflection is used for JSON serialization
-keep class io.supabase.** { *; }

# Supabase Realtime (if used)
-keep class org.java_websocket.** { *; }

# Dart/Flutter generated code - keep all to avoid issues with JIT/AOT transitions
-keep class **.R$* { *; }

# OkHttp (used by Supabase/WorkerClient)
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# Kotlin coroutines (used by many Android libs)
-keep class kotlinx.coroutines.** { *; }

# JSON serialization (Supabase uses this)
-keep class com.google.gson.** { *; }
-keep class kotlinx.serialization.** { *; }

# Platform channel generated code
-keep class io.flutter.plugin.platform.** { *; }

# Prevent obfuscation of native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep annotations
-keepattributes *Annotation*

# Keep generic signature info for reflection
-keepattributes Signature

# Keep line number info for stack traces
-keepattributes SourceFile,LineNumberTable