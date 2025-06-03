import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/services/firestore_services.dart';
import 'package:note_app/widgets/base_page.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _noteController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) {
      return const BasePage(
        title: 'Yeni Not',
        content: Center(child: Text('Lütfen giriş yapın.')),
      );
    }

    return BasePage(
      title: 'Yeni Not',
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Notunuzu yazın',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                if (_noteController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lütfen bir not girin')),
                  );
                  return;
                }

                setState(() => _isLoading = true);

                try {
                  print('Not kaydediliyor... User ID: ${user.uid}');
                  print('Not içeriği: ${_noteController.text.trim()}');

                  final firestoreService = FirestoreService();
                  final noteData = {
                    'content': _noteController.text.trim(),
                    'isStarred': false,
                    'timestamp': DateTime.now().toIso8601String(),
                  };

                  print('Note data: $noteData');

                  await firestoreService.saveNote(user.uid, noteData);

                  print('Not başarıyla kaydedildi!');

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Not başarıyla eklendi')),
                  );
                  _noteController.clear();

                } catch (e) {
                  print('Not kaydetme hatası: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Not eklenemedi: $e')),
                  );
                } finally {
                  if (mounted) {
                    setState(() => _isLoading = false);
                  }
                }
              },
              child: const Text('Notu Kaydet'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}