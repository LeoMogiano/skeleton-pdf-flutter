import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/config/export_router.dart';
import 'package:skeleton_pdf/services/pdf_service.dart';
import 'package:skeleton_pdf/widgets/custom_snackbar.dart';

class CompressionLevelScreen extends StatelessWidget {
  const CompressionLevelScreen({super.key});

  // bool _isSelected(PdfState state, CompressionLevel level) {
  //   return state is PdfLoaded && state.level == level;
  // }

  @override
  Widget build(BuildContext context) {
    final pdfState = context.watch<PdfBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compresión de PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              spacing: 10,
              children: [
                Text(
                  'Selecciona el nivel de compresión:',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),

                LevelWidget(
                  level: 'Baja',
                  description: 'Reducción de tamaño: 20-40%',
                  isSelected: pdfState.currentPdf?.compressionLevel == CompressionLevel.low,
                  onTap: () => context.read<PdfBloc>().add(
                    PdfSetCompressionLevelEvent(
                      CompressionLevel.low,
                    ),
                  ),
                ),
                LevelWidget(
                  level: 'Media',
                  description: 'Reducción de tamaño: 40-60%',
                  isSelected: pdfState.currentPdf?.compressionLevel == CompressionLevel.medium,
                  onTap: () => context.read<PdfBloc>().add(
                    PdfSetCompressionLevelEvent(
                      CompressionLevel.medium,
                    ),
                  ),
                ),
                LevelWidget(
                  level: 'Alta',
                  description: 'Reducción de tamaño: 60-80%',
                  isSelected: pdfState.currentPdf?.compressionLevel == CompressionLevel.high,
                  onTap: () => context.read<PdfBloc>().add(
                    PdfSetCompressionLevelEvent(
                      CompressionLevel.high,
                    ),
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<PdfBloc, PdfState>(
                listener: (context, state) {
                  if (state.currentPdf?.compressedFilePath != null) {
                    appRouter.goNamed(Routes.compressInfo.name);
                  } else if (state.errorMessage != null) {
                    CustomSnackBar.show(
                      context,
                      message: state.errorMessage!,
                      icon: Icons.error,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 2.5.h),
                      child: const CircularProgressIndicator(),
                    );
                  }

                  if (state.currentPdf?.originalFilePath != null) {
                    return ElevatedButton(
                      onPressed: () => context.read<PdfBloc>().add(PdfCompressEvent()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.currentPdf?.compressionLevel == null
                            ? Colors.grey
                            : Colors.blue,
                      ),
                      child: Text(
                        'Comprimir PDF',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  }
                  return const SizedBox.shrink(); // No action needed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    required this.level, required this.description, super.key,
    this.isSelected = false,
    this.onTap,
  });

  final String level;
  final String description;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      shadowColor: Colors.black.withValues(alpha: 0.1),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE0F7FA) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF47A8EB) : Colors.white,
              width: 1.5,
            ),
          ),
          child: Row(
            spacing: 12,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  'assets/svg/file.svg',
                  width: 22.sp,
                  height: 22.sp,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level,
                    style: TextStyle(
                      fontSize: 15.6.sp,
                      color: const Color(0xFF0D171C),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14.6.sp, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
