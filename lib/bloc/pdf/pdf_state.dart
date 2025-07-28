part of 'pdf_bloc.dart';

@immutable
sealed class PdfState {}

final class PdfInitial extends PdfState {}

final class PdfLoading extends PdfState {}

final class PdfLoaded extends PdfState {
  PdfLoaded({
    required this.filePath,
    required this.fileSize,
    this.level
  });

  final String filePath;
  final double fileSize;
  final CompressionLevel? level;
}

final class PdfCompressed extends PdfState {
  PdfCompressed({
    required this.fileName,
    required this.level,
    required this.compressedFilePath,
    required this.originalFileSize,
    required this.compressedFileSize,
  });

  final String compressedFilePath;
  final String fileName;
  final CompressionLevel level;
  final double originalFileSize;
  final double compressedFileSize;
  double get compressionPercentage => ((originalFileSize - compressedFileSize) / originalFileSize) * 100;
}

final class PdfError extends PdfState {
  PdfError(this.message);

  final String message;
}
