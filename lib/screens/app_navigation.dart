import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          enableFeedback: false,
          selectedFontSize: 15.sp,
          unselectedFontSize: 15.sp,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuración',
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          selectedItemColor: const Color(
            0xFF47A8EB,
          ), // Color del ítem seleccionado
          onTap: navigationShell.goBranch,
        ),
      ),
    );
  }
}

// final PdfService _pdfService = PdfService();
//   bool _isCompressing = false;
//   String? _resultMessage;

//   // Indice de la pestaña seleccionada en el BottomNavigationBar
//   int _selectedIndex = 0;

//   // Lista de widgets para cada pestaña
//   // Aquí puedes poner las instancias de tus diferentes pantallas
//   final List<Widget> _widgetOptions = [
//     HomeScreen(),
//     const HistoryScreen(),
//     const ConfigScreen(),
//   ];

//   // Función que se llama cuando se toca un ítem del BottomNavigationBar
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   // Función que se encarga de la lógica de compresión
//   Future<void> _compressPdf() async {
//     // 1. Ocultar cualquier mensaje de error anterior y mostrar indicador
//     setState(() {
//       _isCompressing = true;
//       _resultMessage = null;
//     });
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     // 3. Verificar si se seleccionó un archivo
//     if (result == null || result.files.single.path == null) {
//       setState(() {
//         _isCompressing = false;
//         _resultMessage = 'Selección de archivo cancelada.';
//       });
//       return;
//     }

//     final filePath = result.files.single.path;
//     if (filePath == null) {
//       setState(() {
//         _isCompressing = false;
//         _resultMessage = 'No se pudo obtener la ruta del archivo.';
//       });
//       return;
//     }

//     final inputUri = 'file://$filePath';

//     // 4. Llamar al método de tu servicio con el URI del archivo seleccionado
//     final compressionResult = await _pdfService.compressPdf(
//       inputUri: inputUri,
//       level: CompressionLevel.medium,
//     );

//     // 5. Actualizar la UI con el resultado
//     setState(() {
//       _isCompressing = false;
//       if (compressionResult != null) {
//         final newUri = compressionResult['uri'];
//         final newFileName = compressionResult['fileName'];
//         _resultMessage = '¡PDF comprimido!\nNombre: $newFileName\nURI: $newUri';
//       } else {
//         _resultMessage = 'Error al comprimir el PDF. Revisa los logs.';
//       }
//     });
//   }
