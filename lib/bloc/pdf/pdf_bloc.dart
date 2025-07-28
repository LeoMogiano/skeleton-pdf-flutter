import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:file_picker/file_picker.dart';
import 'package:skeleton_pdf/services/pdf_service.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc() : super(PdfInitial()) {
    on<PdfLoadEvent>(_onPdfLoadEvent);
    on<PdfSetCompressionLevelEvent>(_onPdfSetCompressionLevelEvent);
    on<PdfCompressEvent>(_onPdfCompressEvent);
    on<PdfResetEvent>(_onPdfResetEvent);
  }

  Future<void> _onPdfLoadEvent(PdfLoadEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null || result.files.single.path == null) {
        emit(PdfError('Selección de archivo cancelada.'));
        return;
      }

      final filePath = result.files.single.path;
      if (filePath == null) {
        emit(PdfError('No se pudo obtener la ruta del archivo.'));
        return;
      }

      emit(
        PdfLoaded(
          filePath: filePath,
          fileSize: double.parse((result.files.single.size / 1024).toStringAsFixed(2)),
        ),
      );
    } catch (e) {
      emit(PdfError('Error loading PDF: $e'));
    }
  }

  Future<void> _onPdfSetCompressionLevelEvent(
    PdfSetCompressionLevelEvent event,
    Emitter<PdfState> emit,
  ) async {
    if (state is PdfLoaded) {
      final currentState = state as PdfLoaded;
      emit(
        PdfLoaded(
          filePath: currentState.filePath,
          fileSize: currentState.fileSize,
          level: event.level,
        ),
      );
    } else {
      emit(PdfError('No se ha cargado un PDF válido.'));
    }
  }

  Future<void> _onPdfCompressEvent(PdfCompressEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());
    try {
      final inputUri = 'file://${event.filePath}';

      final compressionResult = await PdfService().compressPdf(
        inputUri: inputUri,
        level: event.level,
      );

      if (compressionResult != null) {

        final compressedFileSize = double.parse(
          double.parse(compressionResult['fileSizeMB']!).toStringAsFixed(2),
        );

        emit(
          PdfCompressed(
            fileName: compressionResult['fileName']!,
            compressedFilePath: compressionResult['uri']!.replaceFirst('file://', ''),
            originalFileSize: event.originalFileSize,
            compressedFileSize: compressedFileSize,
            level: event.level,
          ),
        );
      } else {
        emit(PdfError('Error al comprimir el PDF. Revisa los logs.'));
      }
    } catch (e) {
      emit(PdfError('Error compressing PDF: $e'));
    }
  }

  Future<void> _onPdfResetEvent(PdfResetEvent event, Emitter<PdfState> emit) async {
    emit(PdfInitial());
  }
}
