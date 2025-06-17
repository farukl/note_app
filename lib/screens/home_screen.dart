import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/widgets/base_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      // Kullanıcı giriş yapmamışsa login ekranına yönlendir
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return BasePage(
      title: 'Ana Sayfa',
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hoş geldin!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'E-posta: ${user.email}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 32),
            Card(
              child: ListTile(
                leading: const Icon(Icons.note_add),
                title: const Text('Yeni Not Ekle'),
                subtitle: const Text('Hemen bir not oluştur'),
                onTap: () {
                  Navigator.pushNamed(context, '/add_note');
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Notlarım'),
                subtitle: const Text('Tüm notlarını görüntüle'),
                onTap: () {
                  Navigator.pushNamed(context, '/notes');
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Favoriler'),
                subtitle: const Text('Favori notlarını görüntüle'),
                onTap: () {
                  Navigator.pushNamed(context, '/favorites');
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profil'),
                subtitle: const Text('Profil bilgilerini düzenle'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ),

            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Bize Ulaşın'),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),


            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                await authProvider.logout();
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Çıkış Yap'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}