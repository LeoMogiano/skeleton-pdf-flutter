import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_pdf/i18n/strings.g.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t.configScreen.title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.configScreen.not_configs,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 5.h),
            Text(
              t.configScreen.collaborators,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Leo Mogiano'),
              subtitle: Text(t.configScreen.developer),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              title: const Text('XXXX XXXX'),
              subtitle: Text(t.configScreen.designer),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              title: const Text('XXXX XXXX'),
              subtitle: Text(t.configScreen.tester),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(height: 5.h),
            Text(
              t.configScreen.language,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: LocaleSettings.currentLocale.languageTag,
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(t.configScreen.languageOptions.en),
                ),
                DropdownMenuItem(
                  value: 'es',
                  child: Text(t.configScreen.languageOptions.es),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue == null) return;
                LocaleSettings.setLocaleRaw(newValue);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
