import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/config/app_router.dart';
import 'package:skeleton_pdf/config/app_theme.dart';
import 'package:skeleton_pdf/core/injection.dart';
import 'package:skeleton_pdf/i18n/strings.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PdfBloc>(
          create: (context) => sl<PdfBloc>(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: MediaQuery.of(context).textScaler.clamp(minScaleFactor: 0.8, maxScaleFactor: 1.2),
            ),
            child: MaterialApp.router(
              theme: AppTheme.lightTheme,
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
