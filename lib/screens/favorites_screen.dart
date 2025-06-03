import 'package:flutter/material.dart';
import 'package:note_app/widgets/base_page.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Favoriler',
      content: Center(child: Text('Favori Notlarınız')),
    );
  }
}