part of 'pdf_bloc.dart';

@immutable
class PdfState extends Equatable {

  const PdfState({
    this.isLoading = false,
    this.errorMessage,
    this.currentPdf,
    this.compressedPdfs = const [],
  });
  final bool isLoading;
  final String? errorMessage;
  final PDFCompressed? currentPdf; // Información del PDF que se está procesando actualmente
  final List<PDFCompressed> compressedPdfs;

  PdfState copyWith({
    bool? isLoading,
    String? errorMessage,
    PDFCompressed? currentPdf,
    List<PDFCompressed>? compressedPdfs,
  }) {
    return PdfState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage ??
          this.errorMessage, // Mantiene el valor actual si no se proporciona uno nuevo
      currentPdf:
          currentPdf ?? this.currentPdf, // Mantiene el valor actual si no se proporciona uno nuevo
      compressedPdfs: compressedPdfs ?? this.compressedPdfs,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    currentPdf,
    compressedPdfs,
  ];
}
