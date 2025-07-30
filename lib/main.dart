import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/config/app_router.dart';
import 'package:skeleton_pdf/config/app_theme.dart';
import 'package:skeleton_pdf/services/pdf_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getApplicationSupportDirectory()).path),
  );
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
  runApp(
    DevicePreview(
      // We can use DevicePreview to test the app on different screen sizes and orientations
      // ignore: avoid_redundant_argument_values
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PdfBloc>(
          create: (context) => PdfBloc(PdfService()),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: MediaQuery.of(
                context,
              ).textScaler.clamp(minScaleFactor: 0.8, maxScaleFactor: 1.2),
            ),
            child: MaterialApp.router(
              theme: AppTheme.lightTheme,
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
