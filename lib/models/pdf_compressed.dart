import 'package:equatable/equatable.dart';
import 'package:skeleton_pdf/services/pdf_service.dart';

class PDFCompressed extends Equatable {

  const PDFCompressed({
    this.originalFileName,
    this.originalFilePath,
    this.originalFileSize,
    this.compressionLevel,
    this.compressedFilePath,
    this.compressedFileSize,
    this.compressionDate,
  });

  factory PDFCompressed.fromJson(Map<String, dynamic> json) {
    return PDFCompressed(
      originalFileName: json['originalFileName'] as String,
      originalFilePath: json['originalFilePath'] as String,
      originalFileSize: json['originalFileSize'] as double,
      compressionLevel: json['compressionLevel'] != null
          ? CompressionLevel.values.firstWhere(
              (e) => e.toString().split('.').last == json['compressionLevel'],
              orElse: () => CompressionLevel.medium,
            )
          : null,
      compressedFilePath: json['compressedFilePath'] as String?,
      compressedFileSize: json['compressedFileSize'] as double?,
      compressionDate: json['compressionDate'] != null
          ? DateTime.parse(json['compressionDate'] as String)
          : null,
    );
  }
  final String? originalFileName;
  final String? originalFilePath;
  final double? originalFileSize;
  final CompressionLevel? compressionLevel;
  final String? compressedFilePath;
  final double? compressedFileSize;
  final DateTime? compressionDate;

  String get compressedFileName {
    if (compressedFilePath == null || compressedFilePath!.isEmpty) {
      return 'N/A';
    }
    return compressedFilePath!.split('/').last;
  }

  double get compressionPercentage {
    if (originalFileSize == null || compressedFileSize == null || originalFileSize! <= 0) {
      return 0;
    }
    return ((originalFileSize! - compressedFileSize!) / originalFileSize!) * 100;
  }

  Map<String, dynamic> toJson() {
    return {
      'originalFileName': originalFileName,
      'originalFilePath': originalFilePath,
      'originalFileSize': originalFileSize,
      'compressionLevel': compressionLevel?.toString().split('.').last,
      'compressedFileSize': compressedFileSize,
      'compressionDate': compressionDate?.toIso8601String(),
    };
  }

  PDFCompressed copyWith({
    String? originalFileName,
    String? originalFilePath,
    double? originalFileSize,
    CompressionLevel? compressionLevel,
    String? compressedFilePath,
    double? compressedFileSize,
    DateTime? compressionDate,
  }) {
    return PDFCompressed(
      originalFileName: originalFileName ?? this.originalFileName,
      originalFilePath: originalFilePath ?? this.originalFilePath,
      originalFileSize: originalFileSize ?? this.originalFileSize,
      compressionLevel: compressionLevel ?? this.compressionLevel,
      compressedFilePath: compressedFilePath ?? this.compressedFilePath,
      compressedFileSize: compressedFileSize ?? this.compressedFileSize,
      compressionDate: compressionDate ?? this.compressionDate,
    );
  }

  @override
  List<Object?> get props => [
    originalFileName,
    originalFilePath,
    originalFileSize,
    compressionLevel,
    compressedFilePath,
    compressedFileSize,
    compressionDate,
  ];
}
