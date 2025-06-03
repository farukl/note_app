import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/theme_provider.dart';
import 'package:note_app/widgets/base_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Ayarlar',
      content: ListView(
        children: [
          SwitchListTile(
            title: const Text('Karanlık Tema'),
            value: Provider.of<ThemeProvider>(context).currentTheme == ThemeData.dark(),
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(value ? ThemeData.dark() : ThemeData.light());
            },
          ),
        ],
      ),
    );
  }
}