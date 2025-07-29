import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:skeleton_pdf/models/pdf_compressed.dart';
import 'package:skeleton_pdf/services/pdf_service.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends HydratedBloc<PdfEvent, PdfState> {
  // Asegúrate de que PdfService se pasa al constructor

  PdfBloc(this._pdfService) : super(const PdfState()) {
    on<PdfLoadEvent>(_onPdfLoadEvent);
    on<PdfSetCompressionLevelEvent>(_onPdfSetCompressionLevelEvent);
    on<PdfCompressEvent>(_onPdfCompressEvent);
    on<PdfResetEvent>(_onPdfResetEvent);
  }

  final PdfService _pdfService;

  @override
  PdfState? fromJson(Map<String, dynamic> json) {
    try {
      return PdfState(
        isLoading: json['isLoading'] as bool? ?? false,
        errorMessage: json['errorMessage'] as String?,
        currentPdf: json['currentPdf'] != null
            ? PDFCompressed.fromJson(json['currentPdf'] as Map<String, dynamic>)
            : null,
        compressedPdfs:
            (json['compressedPdfs'] as List<dynamic>?)
                ?.map((item) => PDFCompressed.fromJson(item as Map<String, dynamic>))
                .toList() ??
            const [],
      );
    } on Exception catch (e) {
      developer.log('Error al deserializar PdfState: $e');
      return const PdfState();
    }
  }

  @override
  Map<String, dynamic>? toJson(PdfState state) {
    try {
      return {
        'isLoading': state.isLoading,
        'errorMessage': state.errorMessage,
        'currentPdf': state.currentPdf?.toJson(),
        'compressedPdfs': state.compressedPdfs.map((pdf) => pdf.toJson()).toList(),
      };
    } on Exception catch (e) {
      developer.log('Error al serializar PdfState: $e');
      return null;
    }
  }

  Future<void> _onPdfLoadEvent(PdfLoadEvent event, Emitter<PdfState> emit) async {
    emit(
      state.copyWith(isLoading: true, currentPdf: const PDFCompressed()),
    );
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null || result.files.single.path == null) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Selección de archivo cancelada.',
          ),
        );
        return;
      }

      final filePath = result.files.single.path!;
      final fileName = result.files.single.name;
      final fileSize = result.files.single.size.toDouble();

      emit(
        state.copyWith(
          isLoading: false,
          currentPdf: PDFCompressed(
            originalFileName: fileName,
            originalFilePath: filePath,
            originalFileSize: fileSize / (1024 * 1024),
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar el PDF: $e',
        ),
      );
    }
  }

  Future<void> _onPdfSetCompressionLevelEvent(
    PdfSetCompressionLevelEvent event,
    Emitter<PdfState> emit,
  ) async {
    if (state.currentPdf == null) {
      emit(state.copyWith(errorMessage: 'Por favor, selecciona un archivo PDF primero.'));
      return;
    }

    emit(
      state.copyWith(
        currentPdf: state.currentPdf!.copyWith(
          compressionLevel: event.level,
        ), // Actualizar el nivel
      ),
    );
  }

  Future<void> _onPdfCompressEvent(PdfCompressEvent event, Emitter<PdfState> emit) async {
    if (state.currentPdf?.originalFilePath == null) {
      emit(state.copyWith(errorMessage: 'No se ha seleccionado un archivo PDF para comprimir.'));
      return;
    }
    if (state.currentPdf?.compressionLevel == null) {
      emit(state.copyWith(errorMessage: 'Por favor, selecciona un nivel de compresión.'));
      return;
    }

    emit(state.copyWith(isLoading: true)); // Poner en estado de carga

    try {
      final inputUri = 'file://${state.currentPdf!.originalFilePath}';

      final compressionResult = await _pdfService.compressPdf(
        inputUri: inputUri,
        level: state.currentPdf!.compressionLevel!,
      );

      if (compressionResult != null) {
        final compressedFilePath = compressionResult['uri']!.replaceFirst('file://', '');
        // dos digitos finales
        final compressedFileSize = double.parse(
          double.parse(compressionResult['fileSizeMB']!).toStringAsFixed(2),
        );

        final updatedCurrentPdf = state.currentPdf!.copyWith(
          compressedFilePath: compressedFilePath,
          compressedFileSize: compressedFileSize,
          compressionDate: DateTime.now(),
        );

        final updatedPdfs = List<PDFCompressed>.from(state.compressedPdfs)..add(updatedCurrentPdf);

        emit(
          state.copyWith(
            isLoading: false,
            currentPdf: updatedCurrentPdf,
            compressedPdfs: updatedPdfs,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Error al comprimir el PDF. Revisa los logs.',
          ),
        );
      }
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al comprimir el PDF: $e'));
    }
  }

  Future<void> _onPdfResetEvent(PdfResetEvent event, Emitter<PdfState> emit) async {
    emit(
      PdfState(compressedPdfs: state.compressedPdfs),
    ); // Mantiene el historial de PDFs comprimidos
  }
}
