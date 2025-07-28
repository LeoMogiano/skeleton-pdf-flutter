// Widget separado para el contenido de la pantalla Home
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/config/export_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SkeletonPDF',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 60.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF47A8EB),
                  ),
                  child: Text(
                    'PDF',
                    style: TextStyle(fontSize: 40.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          BlocListener<PdfBloc, PdfState>(
            listener: (context, state) async {
              if (state is PdfLoaded) {
                appRouter.goNamed(
                  Routes.compressLevel.name,
                );
              } else if (state is PdfError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 7.5.h,
                    ),
                    animation: CurvedAnimation(
                      parent: AnimationController(
                        duration: const Duration(milliseconds: 500),
                        vsync: Navigator.of(context),
                      ),
                      curve: Curves.easeInOut,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                    content: Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error, color: Colors.white, size: 24),
                        Expanded(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                await Future<dynamic>.delayed(const Duration(seconds: 2));
                context.read<PdfBloc>().add(PdfResetEvent());
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => context.read<PdfBloc>().add(PdfLoadEvent()),
                child: Text(
                  'Seleccionar Archivo PDF',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
