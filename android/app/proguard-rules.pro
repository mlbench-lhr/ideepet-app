# Regras básicas para projetos Flutter (adicione estas ao seu proguard-rules.pro)

# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

# Se você estiver usando reflection (provavelmente sim)
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod

# Classes de modelo/dados (se você estiver usando - EXTREMAMENTE COMUM)
# Mantenha construtores e campos das suas classes de modelo/dados
# Substitua 'com.yourpackage.models.**' pelo pacote correto dos seus modelos.
-keepclassmembers class com.yourpackage.models.** {
  <init>(...);
  *;
}
# Gson (Se você usa Gson, o que é PROVÁVEL se você tem models.)
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers class * { # Mantém construtores e campos para Gson
  *;
}

# Retrofit (Se você usa Retrofit, o que é PROVÁVEL se você se comunica com APIs)
-keep class retrofit2.** { *; }
-keep interface retrofit2.** { *; }
-keep class com.squareup.okhttp3.** { *; } # Se você estiver usando OkHttp (Retrofit usa por baixo)
-dontwarn retrofit2.**
-dontwarn okhttp3.**
-dontwarn okio.**

# Outras bibliotecas comuns (adicione/remova conforme necessário)

# --- ESPECÍFICO PARA tflite_v2 ---
-keep class sq.flutter.tflite.** { *; }
-dontwarn sq.flutter.tflite.**
# --- FIM DO tflite_v2 ---

#Regras original.
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options$GpuBackend
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options