# Mantener clases de modelos que se usan con serialización/deserialización JSON (ej. GSON, Moshi, Jackson)
# Si tus objetos de datos se convierten a/desde JSON, sus campos y getters/setters a menudo deben conservarse.
-keepclassmembers class com.mogitech.skeletonpdf.skeleton_pdf.models.** {
    *;
}
-keep class com.mogitech.skeletonpdf.skeleton_pdf.models.** { *; }

# Mantener clases que son accedidas vía reflexión (ej. algunos frameworks, inyección de dependencia)
# Si tienes código que busca clases por su nombre de forma dinámica.
-keep class com.mogitech.skeletonpdf.skeleton_pdf.utils.MyReflectionClass {
    *;
}

# Mantener enums, ya que su método valueOf() a menudo es accedido por reflexión
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Reglas para bibliotecas de terceros
# Muchas bibliotecas populares (como Firebase, Retrofit, Room, etc.) tienen sus propias reglas de ProGuard recomendadas.
# Siempre revisa la documentación de la biblioteca.

# Para PDFBox-Android (la que estás usando):
# Si encuentras errores al usar PDFBox en modo release, busca si tienen reglas de ProGuard específicas.
# A veces, estas reglas se incluyen automáticamente por el Android Gradle Plugin o por la misma biblioteca.
# Si no, podrías necesitar algo como:
-keep class org.apache.pdfbox.** { *; }
-keep class com.tom_roush.pdfbox.** { *; }
-keep class org.apache.fontbox.** { *; }
-keep class org.apache.commons.logging.** { *; }

# Reglas generales para Flutter (aunque el plugin de Flutter ya maneja muchas de estas)
# Es bueno tenerlas en cuenta si depuras problemas específicos.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Evitar que se ofusquen clases nativas/JNI si interactúas con ellas
# Si tienes código nativo (C/C++) que llama a métodos Java específicos.
# -keep class com.example.MyJniClass {
#     native <methods>;
# }

# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.gemalto.jp2.JP2Decoder
-dontwarn com.gemalto.jp2.JP2Encoder
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task