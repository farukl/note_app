import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/services/firestore_services.dart';
import 'package:note_app/widgets/base_page.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _favoriteNotes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteNotes();
  }

  Future<void> _loadFavoriteNotes() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final notes = await _firestoreService.getFavoriteNotes(user.uid);
      setState(() {
        _favoriteNotes = notes;
        _isLoading = false;
      });
    } catch (e) {
      print('Favori notlar yüklenirken hata: $e');
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Favori notlar yüklenemedi: $e')),
      );
    }
  }

  Future<void> _toggleFavorite(String noteId, bool currentValue) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) return;

    try {
      await _firestoreService.updateNote(user.uid, noteId, {
        'isStarred': !currentValue,
      });
      _loadFavoriteNotes(); // Listeyi yenile
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Güncelleme hatası: $e')),
      );
    }
  }

  String _formatDate(String timestamp) {
    try {
      final date = DateTime.parse(timestamp);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Tarih yok';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return const BasePage(
        title: 'Favoriler',
        content: Center(child: Text('Lütfen giriş yapın.')),
      );
    }

    return BasePage(
      title: 'Favoriler',
      content: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteNotes.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Henüz favori not yok',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Notlarınızı favorilere eklemek için yıldız butonuna tıklayın',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/notes');
              },
              icon: const Icon(Icons.notes),
              label: const Text('Notlarıma Git'),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadFavoriteNotes,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _favoriteNotes.length,
          itemBuilder: (context, index) {
            final note = _favoriteNotes[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                title: Text(
                  note['content'] ?? 'Boş not',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  _formatDate(note['timestamp'] ?? ''),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () => _toggleFavorite(note['id'], true),
                  icon: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  tooltip: 'Favorilerden çıkar',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}