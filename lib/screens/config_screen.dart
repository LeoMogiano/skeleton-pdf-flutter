import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // no hay configuraciones específicas en este momento
            Text(
              'Actualmente no hay configuraciones disponibles.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 5.h),
            Text(
              'Colaboradores',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            const ListTile(
              title: Text('Leo Mogiano'),
              subtitle: Text('Desarrollador'),
              contentPadding: EdgeInsets.zero,
            ),
            const ListTile(
              title: Text('XXXX XXXX'),
              subtitle: Text('Diseñador de UI/UX'),
              contentPadding: EdgeInsets.zero,
            ),
            const ListTile(
              title: Text('XXXX XXXX'),
              subtitle: Text('Tester'),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
