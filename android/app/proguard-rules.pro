# Keep Razorpay SDK classes and annotations
-keep class com.razorpay.** { *; }
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
-keepclassmembers class * {
    @proguard.annotation.Keep *;
    @proguard.annotation.KeepClassMembers *;
}
-dontwarn com.razorpay.**
