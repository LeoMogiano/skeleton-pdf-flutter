import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/models/pdf_compressed.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Historial'),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          BlocBuilder<PdfBloc, PdfState>(
            builder: (context, state) {
              if (state.compressedPdfs.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No hay historial de compresiones.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.compressedPdfs.length,
                    (context, index) {
                      final pdf = state.compressedPdfs[index];
                      return HistoryWidget(pdf);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// widget

class HistoryWidget extends StatelessWidget {
  const HistoryWidget(this.pdf, {super.key});

  final PDFCompressed pdf;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset('assets/svg/file.svg', width: 8.w),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pdf.originalFileName!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),

                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              '${pdf.originalFileSize!.toStringAsFixed(2)} MB',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            Text(
                              '-',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              pdf.compressionLevel != null
                                  ? '${pdf.compressionLevel!.name.toUpperCase()} COMPRESIÓN'
                                  : 'Desconocido',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
