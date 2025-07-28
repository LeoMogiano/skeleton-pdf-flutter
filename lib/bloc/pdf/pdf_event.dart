part of 'pdf_bloc.dart';

@immutable
sealed class PdfEvent {}


class PdfLoadEvent extends PdfEvent {
  PdfLoadEvent();
}

// pdfSetCompressionLevelEvent
class PdfSetCompressionLevelEvent extends PdfEvent {
  PdfSetCompressionLevelEvent(this.level);

  final CompressionLevel level;
}

class PdfCompressEvent extends PdfEvent {

  PdfCompressEvent(this.filePath, this.level, {
    this.originalFileSize = 0.0,
  });

  final String filePath;
  final CompressionLevel level;
  final double originalFileSize;
}

class PdfResetEvent extends PdfEvent {
  PdfResetEvent();
}
