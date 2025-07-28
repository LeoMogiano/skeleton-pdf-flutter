import 'dart:developer' as developer;
import 'package:flutter/services.dart';

enum CompressionLevel { high, medium, low }

class PdfService {
  static const MethodChannel _platform = MethodChannel('com.mogitech.skeletonpdf/pdf_compressor');


  Future<Map<String, String>?> compressPdf({
    required String inputUri,
    required CompressionLevel level,
  }) async {
    try {
      final result = await _platform.invokeMethod('compressPdf', {
        'inputUri': inputUri,
        'level': level.name,
      });
      if (result != null) {
        final mapResult = result as Map<dynamic, dynamic>;
        return {
          'uri': mapResult['uri'] as String,
          'fileName': mapResult['fileName'] as String,
          'fileSizeMB': (mapResult['fileSizeMB'] as double).toString()
        };
      }
    } on PlatformException catch (e) {
      developer.log("Fallo al comprimir el PDF: '${e.message}'.");
    }
    return null;
  }
}
