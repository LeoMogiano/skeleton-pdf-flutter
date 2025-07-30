package com.mogitech.skeletonpdf.services

import android.content.ContentValues
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Matrix
import android.net.Uri
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import android.graphics.Bitmap
import androidx.core.graphics.createBitmap
import com.tom_roush.pdfbox.android.PDFBoxResourceLoader
import com.tom_roush.pdfbox.pdmodel.PDDocument
import com.tom_roush.pdfbox.pdmodel.PDPage
import com.tom_roush.pdfbox.pdmodel.PDPageContentStream
import com.tom_roush.pdfbox.pdmodel.common.PDRectangle
import com.tom_roush.pdfbox.pdmodel.graphics.image.JPEGFactory
import android.graphics.pdf.PdfRenderer
import android.os.Build
import android.os.ParcelFileDescriptor
import android.provider.OpenableColumns
import androidx.annotation.RequiresApi
import java.io.File
import java.io.OutputStream
import kotlinx.coroutines.delay

enum class CompressionLevel(val quality: Int) {
    HIGH(75),
    MEDIUM(50),
    LOW(25)
}

class PdfCompressorService(private val context: Context) {

    init {
        PDFBoxResourceLoader.init(context)
    }

    /**
     * Comprime un PDF y retorna su URI de salida, nombre de archivo y peso en MB.
     * @param inputUri URI del archivo PDF original.
     * @param level Nivel de compresión deseado.
     * @return Triple con el URI, el nombre del archivo comprimido y su peso en MB (Double), o null si falla.
     */
    @RequiresApi(Build.VERSION_CODES.Q)
    suspend fun compressPdf(
        inputUri: Uri,
        level: CompressionLevel
    ): Triple<Uri, String, Double>? {
        val resolver = context.contentResolver
        val inputFile = File(context.cacheDir, "input.pdf")

        resolver.openInputStream(inputUri)?.use { inputStream ->
            inputFile.outputStream().use { outputStream ->
                inputStream.copyTo(outputStream)
            }
        } ?: return null

        val pfd = ParcelFileDescriptor.open(inputFile, ParcelFileDescriptor.MODE_READ_ONLY)
        val renderer = PdfRenderer(pfd)
        val newDoc = PDDocument()

        val quality = level.quality
        val zoom = when (level) {
            CompressionLevel.HIGH -> 1.0f
            CompressionLevel.MEDIUM -> 1.5f
            CompressionLevel.LOW -> 2.0f
        }

        try {
            for (i in 0 until renderer.pageCount) {
                val page = renderer.openPage(i)
                val width = (page.width * zoom).toInt()
                val height = (page.height * zoom).toInt()
                val bitmap = createBitmap(width, height)
                val canvas = Canvas(bitmap)
                canvas.drawColor(Color.WHITE)
                val matrix = Matrix().apply { setScale(zoom, zoom) }
                page.render(bitmap, null, matrix, PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY)
                page.close()
                val mediaBox = PDRectangle(width.toFloat(), height.toFloat())
                val newPage = PDPage(mediaBox)
                newDoc.addPage(newPage)
                val jpegImage = JPEGFactory.createFromImage(newDoc, bitmap, quality.toFloat() / 100f)
                val contentStream = PDPageContentStream(newDoc, newPage)
                contentStream.drawImage(jpegImage, 0f, 0f, mediaBox.width, mediaBox.height)
                contentStream.close()
                bitmap.recycle()
            }
        } finally {
            renderer.close()
            pfd.close()
            inputFile.delete()
        }

        // --- Logging for original file name acquisition ---
        val originalFileName = getFileNameFromUri(context, inputUri) ?: "documento_original"
        // --- End of logging ---

        val baseFileName = originalFileName.substringBeforeLast(".")
        val extension = originalFileName.substringAfterLast(".", "pdf")
        val newFileName = "${baseFileName}_compress.$extension"

        Log.d("PdfCompressorService", "Generated new file name: '$newFileName'")

        val values = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, newFileName)
            put(MediaStore.MediaColumns.MIME_TYPE, "application/pdf")
            put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
            put(MediaStore.MediaColumns.IS_PENDING, 1)
        }

        var outputUri: Uri? = null
        try {
            outputUri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
            if (outputUri == null) {
                newDoc.close()
                return null
            }

            resolver.openOutputStream(outputUri)?.use { outputStream ->
                newDoc.save(outputStream)
            } ?: run {
                newDoc.close()
                return null
            }

            val pendingValues = ContentValues().apply {
                put(MediaStore.MediaColumns.IS_PENDING, 0)
                put(MediaStore.MediaColumns.DISPLAY_NAME, newFileName) // Ensure it's set again
            }
            resolver.update(outputUri, pendingValues, null, null)

            Log.d("PdfCompressorService", "PDF saved. Attempting to get size from: $outputUri")

            var fileSizeInBytes: Long? = null
            var attempts = 0
            val maxAttempts = 5
            val delayMs = 50L

            while (fileSizeInBytes == null || fileSizeInBytes == 0L && attempts < maxAttempts) {
                if (attempts > 0) {
                    delay(delayMs * attempts)
                    Log.d("PdfCompressorService", "Retrying size query (attempt ${attempts + 1})...")
                }
                fileSizeInBytes = getFileSizeFromUri(context, outputUri)
                attempts++
            }

            val fileSizeInMB = fileSizeInBytes?.toDouble()?.let { it / (1024.0 * 1024.0) } ?: 0.0

            Log.d("PdfCompressorService", "Resulting file size: $fileSizeInBytes bytes ($fileSizeInMB MB)")

            return Triple(outputUri, newFileName, fileSizeInMB)
        } catch (e: Exception) {
            Log.e("Compression", "Error saving compressed PDF: ${e.message}", e)
            if (outputUri != null) {
                resolver.delete(outputUri, null, null)
            }
            return null
        } finally {
            newDoc.close()
        }
    }

    private fun createBitmap(width: Int, height: Int): Bitmap {
        return Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
    }

    private fun getFileNameFromUri(context: Context, uri: Uri): String? {
        Log.d("PdfCompressorService", "getFileNameFromUri: Attempting to get name for URI: $uri")
        var fileName: String? = null
        val cursor = context.contentResolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
        cursor?.use {
            Log.d("PdfCompressorService", "getFileNameFromUri: Cursor is not null. Column count: ${it.columnCount}")
            if (it.moveToFirst()) {
                val nameIndex = it.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                Log.d("PdfCompressorService", "getFileNameFromUri: DISPLAY_NAME index: $nameIndex")
                if (nameIndex != -1) {
                    fileName = it.getString(nameIndex)
                    Log.d("PdfCompressorService", "getFileNameFromUri: Found name from cursor: '$fileName'")
                } else {
                    Log.w("PdfCompressorService", "getFileNameFromUri: ${OpenableColumns.DISPLAY_NAME} column not found for URI: $uri")
                }
            } else {
                Log.w("PdfCompressorService", "getFileNameFromUri: Cursor could not move to first row for URI: $uri")
            }
        } ?: run {
            Log.e("PdfCompressorService", "getFileNameFromUri: Cursor was null for URI: $uri")
        }

        // Fallback to Uri path segment if display name is still null
        if (fileName.isNullOrBlank()) {
            val pathSegment = uri.lastPathSegment
            if (!pathSegment.isNullOrBlank()) {
                // This might include /document/raw: or numbers, so we clean it up
                // Example: content://com.android.providers.downloads.documents/document/raw:/storage/emulated/0/Download/my_doc.pdf
                // lastPathSegment might be "raw:/storage/emulated/0/Download/my_doc.pdf"
                // Or just "my_doc.pdf" if it's simpler
                val cleanedPathSegment = pathSegment.substringAfterLast(":") // Remove "raw:" prefix
                                                    .substringAfterLast("/") // Get actual file name
                if (cleanedPathSegment.isNotBlank()) {
                    fileName = cleanedPathSegment
                    Log.d("PdfCompressorService", "getFileNameFromUri: Fallback to path segment: '$fileName'")
                }
            }
        }
        return fileName
    }

    // ... (getFileSizeFromUri remains the same) ...
    /**
     * Obtiene el tamaño de un archivo en bytes a partir de su URI.
     * @param context Contexto de la aplicación.
     * @param uri URI del archivo.
     * @return Tamaño del archivo en bytes (Long), o null si no se puede obtener.
     */
    private fun getFileSizeFromUri(context: Context, uri: Uri): Long? {
        val cursor = context.contentResolver.query(uri, arrayOf(OpenableColumns.SIZE), null, null, null)
        cursor?.use {
            if (it.moveToFirst()) {
                val sizeIndex = it.getColumnIndex(OpenableColumns.SIZE)
                if (sizeIndex != -1) {
                    val size = it.getLong(sizeIndex)
                    Log.d("PdfCompressorService", "getFileSizeFromUri: Found size: $size bytes for URI: $uri")
                    return size
                } else {
                    Log.w("PdfCompressorService", "getFileSizeFromUri: ${OpenableColumns.SIZE} column not found for URI: $uri")
                }
            } else {
                Log.w("PdfCompressorService", "getFileSizeFromUri: Cursor could not move to first row for URI: $uri")
            }
        } ?: run {
            Log.e("PdfCompressorService", "getFileSizeFromUri: Cursor was null for URI: $uri")
        }
        return null
    }
}