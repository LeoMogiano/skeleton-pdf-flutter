package com.mogitech.skeletonpdf

import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.net.toUri
import com.mogitech.skeletonpdf.services.CompressionLevel // <--- ADD THIS LINE
import com.mogitech.skeletonpdf.services.PdfCompressorService // <--- ADD THIS LINE
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : FlutterActivity() {
    private val CHANNEL_NAME = "com.mogitech.skeletonpdf/pdf_compressor"
    private lateinit var pdfCompressorService: PdfCompressorService

    @RequiresApi(Build.VERSION_CODES.Q)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

         pdfCompressorService = PdfCompressorService(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
             .setMethodCallHandler { call, result ->
                 handleMethodCall(call, result)
             }
    }

    @RequiresApi(Build.VERSION_CODES.Q)
    private fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "compressPdf" -> {
                // Aquí usamos tu servicio
                val args = call.arguments as Map<String, Any>
                val uriString = args["inputUri"] as String
                val levelString = args["level"] as String
                val inputUri = uriString.toUri()
                val level = CompressionLevel.valueOf(levelString.uppercase())

                // Llamamos a la función asíncrona dentro de una corrutina
                CoroutineScope(Dispatchers.IO).launch {
                    try {
                        // *** ¡CAMBIO AQUÍ! Esperamos un Triple (Uri, String, Double) ***
                        val outputResult = pdfCompressorService.compressPdf(inputUri, level)
                        withContext(Dispatchers.Main) {
                            if (outputResult != null) {
                                // Desestructuramos el Triple
                                val (outputUri, newFileName, fileSizeMB) = outputResult
                                result.success(mapOf(
                                    "uri" to outputUri.toString(),
                                    "fileName" to newFileName,
                                    "fileSizeMB" to fileSizeMB
                                ))
                            } else {
                                result.error("COMPRESSION_FAILED", "Fallo al comprimir o guardar el PDF.", null)
                            }
                        }
                    } catch (e: Exception) {
                        withContext(Dispatchers.Main) {
                            result.error("COMPRESSION_ERROR", e.message, e.toString())
                        }
                    }
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}