import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/config/export_router.dart';

class CompressInfoScreen extends StatelessWidget {
  const CompressInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfState = context.watch<PdfBloc>().state as PdfCompressed;

    return Scaffold(
      appBar: AppBar(
        title: Text('Compresión completada'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            Text(
              'Archivo comprimido con éxito',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),

            Text(
              'Se ha guardado en la carpeta de descargas.',
              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 16.sp, decoration: TextDecoration.underline),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 20,
              children: [
                Expanded(
                  child: Container(
                    height: 20.h,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          'Tamaño\noriginal',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16.4.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${(pdfState.originalFileSize / 1024).toStringAsFixed(2)} MB',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        //red percentage
                        Text(
                          '-${(pdfState.compressionPercentage).toStringAsFixed(2)}%',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16.sp, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 20.h,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          'Tamaño\ncomprimido',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16.4.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${(pdfState.compressedFileSize).toStringAsFixed(2)} MB',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // boton comprimir nuevo
            ElevatedButton(
              onPressed: () {
                // context.read<PdfBloc>().add(PdfResetEvent());
                appRouter.goNamed(Routes.home.name);
              },
              child: Text('Comprimir otro PDF'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
