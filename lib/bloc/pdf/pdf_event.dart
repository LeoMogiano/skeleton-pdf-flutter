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
  PdfCompressEvent();
}

class PdfResetEvent extends PdfEvent {
  PdfResetEvent();
}
