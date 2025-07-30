import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/config/export_router.dart';
import 'package:skeleton_pdf/i18n/strings.g.dart';
import 'package:skeleton_pdf/widgets/custom_snackbar.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
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
            BlocListener<PdfBloc, PdfState>(
              listener: (context, state) async {
                if (state.currentPdf?.originalFilePath != null) {
                  appRouter.goNamed(
                    Routes.compressLevel.name,
                  );
                } else if (state.errorMessage != null) {
                  CustomSnackBar.show(
                    context,
                    message: state.errorMessage!,
                    icon: Icons.error,
                    backgroundColor: Colors.red,
                  );
                  await Future<dynamic>.delayed(const Duration(seconds: 2));
                  if (!context.mounted) return;
                  context.read<PdfBloc>().add(PdfResetEvent());
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () => context.read<PdfBloc>().add(PdfLoadEvent()),
                  child: Text(
                    t.homeScreen.buttonText,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
