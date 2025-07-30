import 'package:get_it/get_it.dart';
import 'package:skeleton_pdf/bloc/pdf/pdf_bloc.dart';
import 'package:skeleton_pdf/services/pdf_service.dart';

final GetIt sl = GetIt.instance;

void initDependencies() {
  // FEATURES
  // PDF Feature
  sl..registerLazySingleton(() => PdfBloc(sl())) // Registramos PdfBloc, y le inyectamos PdfService

  // SERVICES
  ..registerLazySingleton(PdfService.new); // Registramos PdfService como un singleton perezoso

  // Añade aquí más registros de dependencias a medida que tu aplicación crezca
  // Por ejemplo:
  // sl.registerLazySingleton(() => AuthService());
  // sl.registerFactory(() => AuthBloc(sl()));
}
