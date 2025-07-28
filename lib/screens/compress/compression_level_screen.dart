import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/config/export_router.dart';
import 'package:skeleton_pdf/services/pdf_service.dart';

class CompressionLevelScreen extends StatelessWidget {
  const CompressionLevelScreen({super.key});

  bool _isSelected(PdfState state, CompressionLevel level) {
    return state is PdfLoaded && state.level == level;
  }

  @override
  Widget build(BuildContext context) {
    final pdfState = context.watch<PdfBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text('Compresión de PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  isSelected: _isSelected(pdfState, CompressionLevel.low),
                  onTap: () => context.read<PdfBloc>().add(
                    PdfSetCompressionLevelEvent(
                      CompressionLevel.low,
                    ),
                  ),
                ),
                LevelWidget(
                  level: 'Media',
                  description: 'Reducción de tamaño: 40-60%',
                  isSelected: _isSelected(pdfState, CompressionLevel.medium),
                  onTap: () => context.read<PdfBloc>().add(
                    PdfSetCompressionLevelEvent(
                      CompressionLevel.medium,
                    ),
                  ),
                ),
                LevelWidget(
                  level: 'Alta',
                  description: 'Reducción de tamaño: 60-80%',
                  isSelected: _isSelected(pdfState, CompressionLevel.high),
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
                  if (state is PdfCompressed) {
                    appRouter.goNamed(Routes.compressInfo.name);
                  } else if (state is PdfError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PdfLoading) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 2.5.h),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is PdfLoaded) {
                    return ElevatedButton(
                      onPressed: () => context.read<PdfBloc>().add(
                        PdfCompressEvent(
                          state.filePath,
                          state.level!,
                          originalFileSize: state.fileSize,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.level == null ? Colors.grey : Colors.blue,
                      ),
                      child: Text(
                        'Comprimir PDF',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  }
                  return SizedBox.shrink(); // No action needed
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
    super.key,
    required this.level,
    required this.description,
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
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
                      color: Color(0xFF0D171C),
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
